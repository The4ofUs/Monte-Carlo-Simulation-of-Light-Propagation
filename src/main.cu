#include "RandomWalk.h"
#include "Detector.h"
#include "Vector.h"
#include "common.h"
#include "Photon.h"
#include "Tissue.h"
#define NUMBER_OF_PHOTONS 100
#define THREADS_PER_BLOCK 1024
#define DETECTOR_RADIUS 50.f
#define DETECTOR_POSITION Point(0.f, 0.f, 10.f)
#define DETECTOR_LOOK_DOWNWARDS Vector(0.f, 0.f, -1.f)
#define TISSUE_THICKNESS 2.5f
#define TISSUE_ABSORBTION_COEFFICIENT 1.f
#define TISSUE_SCATTERING_COEFFICIENT 100.f
#define TISSUE_ALIGNED_WITH_XAXIS_1 Point(-5.f, 0.f, 0.f)
#define TISSUE_ALIGNED_WITH_XAXIS_2 Point(5.f, 0.f, 0.f)

void streamOut(Photon *_cpuPhotons);
char *stateToString(int state);

__global__ void finalState(unsigned int seed, curandState_t *states, Photon *_gpuPhotons, Detector detector, RNG rng, Tissue tissue, int n)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n)
    {
        curand_init(seed, idx, 0, &states[idx]);
        Photon finalState = Photon();
        finalState = randomWalk(states, idx, detector, rng, tissue);
        _gpuPhotons[idx] = finalState;
    }
}

int main()
{
    int nBlocks = NUMBER_OF_PHOTONS / THREADS_PER_BLOCK + 1;
    curandState_t *states;
    cudaMalloc((void **)&states, NUMBER_OF_PHOTONS * sizeof(curandState_t));
    // Allocate host memory for final positions
    Photon *_cpuPhotons = (Photon *)malloc(sizeof(Photon) * NUMBER_OF_PHOTONS);
    // Allocate device  memory for final positions
    Photon *_gpuPhotons = nullptr;
    cudaMalloc((void **)&_gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon));
    // Initialize the Boundary and the RandomNumberGenerator
    RNG rng;
    //Boundary boundary = Boundary(BOUNDARY_RADIUS, Point());
    Detector detector = Detector(DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOK_DOWNWARDS);
    Tissue tissue = Tissue(TISSUE_THICKNESS, TISSUE_ALIGNED_WITH_XAXIS_1, TISSUE_ALIGNED_WITH_XAXIS_2, TISSUE_ABSORBTION_COEFFICIENT, TISSUE_SCATTERING_COEFFICIENT);
    // Kernel Call
    //finalPosition<<<nBlocks,THREADS_PER_BLOCK>>>(time(0), states , _gpuPoints, boundary, rng, NUMBER_OF_PHOTONS);
    finalState<<<nBlocks, THREADS_PER_BLOCK>>>(time(0), states, _gpuPhotons, detector, rng, tissue, NUMBER_OF_PHOTONS);
    // Copy device data to host memory to stream them out
    cudaMemcpy(_cpuPhotons, _gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon), cudaMemcpyDeviceToHost);
    streamOut(&_cpuPhotons[0]);
    free(_cpuPhotons);
    cudaFree(_gpuPhotons);
    return 0;
}

void streamOut(Photon *_cpuPhotons)
{
    FILE *output;
    output = fopen("output.csv", "w");
    for (int i = 0; i < NUMBER_OF_PHOTONS; i++)
    {
        // Streaming out my output in a log file
        fprintf(output, "%f,%f,%f,%s\n", _cpuPhotons[i].position().x(), _cpuPhotons[i].position().y(), _cpuPhotons[i].position().z(), stateToString(_cpuPhotons[i].state()));
    }
}

char *stateToString(int state)
{
    char const *states[3] = {"Detected", "Terminated", "Unknown"};
    if (state == 0)
    {
        return (char *)states[0];
    }
    else if (state == -1)
    {
        return (char *)states[1];
    }

    return (char *)states[2];
}
