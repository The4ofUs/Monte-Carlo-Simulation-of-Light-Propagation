#include "code/headers/randomwalk.h"
#include <sstream>

#define NUMBER_OF_PHOTONS 1000
#define THREADS_PER_BLOCK 1024
#define DETECTOR_RADIUS 100.f
#define DETECTOR_POSITION Point(0.f, 0.f, 50.f)
#define DETECTOR_LOOKAT Vector(0.f, 0.f, -1.f)
#define TISSUE_RADIUS 1000.f
#define LAYER_ABSORBTION_COEFFICIENT1 1.f
#define LAYER_SCATTERING_COEFFICIENT1 100.f
#define LAYER_ABSORBTION_COEFFICIENT2 1.f
#define LAYER_SCATTERING_COEFFICIENT2 50.f
#define LAYER_ABSORBTION_COEFFICIENT3 10.f
#define LAYER_SCATTERING_COEFFICIENT3 100.f
#define LAYER_CENTER_00 Point(0.f, 0.f, 50.f)
#define LAYER_CENTER_01 Point(0.f, 0.f, -50.f)
#define LAYER_CENTER_11 Point(0.f, 0.f, -150.f)
#define LAYER_CENTER_22 Point(0.f, 0.f, -250.f)


void streamOut(Photon *_cpuPhotons);

__global__ void finalState(unsigned int seed, curandState_t *states, Photon *_gpuPhotons, Detector detector, RNG rng, MultiLayer layer1, MultiLayer layer2, MultiLayer layer3 ,int n)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n)
    {
        curand_init(seed, idx, 0, &states[idx]);
        Photon finalState = randomWalk(states, idx, detector, rng, layer1, layer2, layer3);
        _gpuPhotons[idx] = finalState;
    }
}


int main()
{
    int nBlocks = NUMBER_OF_PHOTONS + THREADS_PER_BLOCK - 1 / THREADS_PER_BLOCK;
    curandState_t *states;
    cudaMalloc((void **)&states, NUMBER_OF_PHOTONS * sizeof(curandState_t));
    Photon *_cpuPhotons = (Photon *)malloc(sizeof(Photon) * NUMBER_OF_PHOTONS);
    Photon *_gpuPhotons = nullptr;
    cudaMalloc((void **)&_gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon));
    RNG rng;
    Detector detector = Detector(DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOKAT);
    MultiLayer layer1 = MultiLayer(TISSUE_RADIUS, LAYER_CENTER_00, LAYER_CENTER_01, LAYER_ABSORBTION_COEFFICIENT1, LAYER_SCATTERING_COEFFICIENT1);
    MultiLayer layer2 = MultiLayer(TISSUE_RADIUS, LAYER_CENTER_01, LAYER_CENTER_11, LAYER_ABSORBTION_COEFFICIENT2, LAYER_SCATTERING_COEFFICIENT2);
    MultiLayer layer3 = MultiLayer(TISSUE_RADIUS, LAYER_CENTER_11, LAYER_CENTER_22, LAYER_ABSORBTION_COEFFICIENT3, LAYER_SCATTERING_COEFFICIENT3);

    finalState<<<nBlocks, THREADS_PER_BLOCK>>>(time(0), states, _gpuPhotons, detector, rng, layer1, layer2, layer3, NUMBER_OF_PHOTONS);
    cudaMemcpy(_cpuPhotons, _gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon), cudaMemcpyDeviceToHost);
    streamOut(&_cpuPhotons[0]);
    free(_cpuPhotons);
    cudaFree(_gpuPhotons);
    cudaFree(states);
    return 0;
}

void streamOut(Photon *_cpuPhotons)
{
    FILE *output;
    output = fopen("results.csv", "w");
    std::string state;
    //Header
    fprintf(output, "%s,%s,%s,%s,%s\n", "X", "Y", "Z", "Weight", "State");
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



