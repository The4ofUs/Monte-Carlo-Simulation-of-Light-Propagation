#include "code/headers/randomwalk.h"

#define NUMBER_OF_PHOTONS 1000
#define THREADS_PER_BLOCK 1024
#define DETECTOR_RADIUS 10.f
#define DETECTOR_POSITION Point(0.f, 0.f, 50.f)
#define DETECTOR_LOOK_DOWNWARDS Vector(0.f, 0.f, -1.f)
#define TISSUE_RADIUS 100.f
#define TISSUE_ABSORBTION_COEFFICIENT 1.f
#define TISSUE_SCATTERING_COEFFICIENT 100.f
#define TISSUE_CENTER_1 Point(0.f, 0.f, 50.f)
#define TISSUE_CENTER_2 Point(0.f, 0.f, -50.f)

void streamOut(Photon *_cpuPhotons);
char *stateToString(int state);

__global__ void finalState(unsigned int seed, curandState_t *states, Photon *_gpuPhotons, Detector detector, RNG rng, Tissue tissue, int n)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n)
    {
        curand_init(seed, idx, 0, &states[idx]);
        Photon finalState = randomWalk(states, idx, detector, rng, tissue);
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
    Tissue tissue = Tissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, TISSUE_ABSORBTION_COEFFICIENT, TISSUE_SCATTERING_COEFFICIENT);
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
    std::string state;
    // Adding Meta-data to the output file
    /*
    *   This Particular order should be maintained if the output was to be read using the Plotter 
    */
    fprintf(output, "X, Y, Z, WEIGHT, STATE,photon_num,%i,threads_per_block,%i,detector_radius,%f,detector_pos,%f,%f,%f,detector_lookAt,%f,%f,%f,tissue_radius,%f,absorp_coeff,%f,scatter_coeff,%f,tissue_center_1,%f,%f,%f,tissue_center_2,%f,%f,%f\n"
    ,NUMBER_OF_PHOTONS, THREADS_PER_BLOCK, DETECTOR_RADIUS, DETECTOR_POSITION.x(), DETECTOR_POSITION.y(), DETECTOR_POSITION.z()
    , DETECTOR_LOOK_DOWNWARDS.x(), DETECTOR_LOOK_DOWNWARDS.y(), DETECTOR_LOOK_DOWNWARDS.z(), TISSUE_RADIUS, TISSUE_ABSORBTION_COEFFICIENT
    , TISSUE_SCATTERING_COEFFICIENT, TISSUE_CENTER_1.x(), TISSUE_CENTER_1.y(), TISSUE_CENTER_1.z(), TISSUE_CENTER_2.x(), TISSUE_CENTER_2.y()
    , TISSUE_CENTER_2.z());

    for (int i = 0; i < NUMBER_OF_PHOTONS; i++)
    {
        switch (_cpuPhotons[i].getState())
        {
        case (-1):
            state = "TERMINATED";
            break;
        case (0):
            state = "ROAMING";
            break;
        case (1):
            state = "DETECTED";
            break;
        case (2):
            state = "ESCAPED";
            break;
        }
        // Streaming out my output in a log file
        fprintf(output, "%f,%f,%f,%f,%s\n", _cpuPhotons[i].getPosition().x(), _cpuPhotons[i].getPosition().y(), _cpuPhotons[i].getPosition().z(), _cpuPhotons[i].getWeight(), state.c_str());
    }
}
