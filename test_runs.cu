#include "code/headers/randomwalk.h"

#define NUMBER_OF_PHOTONS 1000
#define THREADS_PER_BLOCK 1024
#define DETECTOR_RADIUS 10.f
#define DETECTOR_POSITION Point(0.f, 0.f, 50.f)
#define DETECTOR_LOOKAT Vector(0.f, 0.f, -1.f)
#define TISSUE_RADIUS 100.f
#define TISSUE_ABSORBTION_COEFFICIENT 1.f
#define TISSUE_SCATTERING_COEFFICIENT 100.f
#define TISSUE_CENTER_1 Point(0.f, 0.f, 50.f)
#define TISSUE_CENTER_2 Point(0.f, 0.f, -50.f)

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

int main( int argc, char *argv[] ){
    int NUMBER_OF_TEST_RUNS = std::atoi(argv[1]);
    float totalTime = 0;
        for (int i= 0; i<NUMBER_OF_TEST_RUNS; i++){
            int nBlocks = NUMBER_OF_PHOTONS / THREADS_PER_BLOCK + 1;
            RNG rng;
            Detector detector = Detector(DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOKAT);
            Tissue tissue = Tissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, TISSUE_ABSORBTION_COEFFICIENT, TISSUE_SCATTERING_COEFFICIENT);
            curandState_t *states;
            cudaMalloc((void **)&states, NUMBER_OF_PHOTONS * sizeof(curandState_t));
            Photon *_cpuPhotons = (Photon *)malloc(sizeof(Photon) * NUMBER_OF_PHOTONS);
            Photon *_gpuPhotons = nullptr;
            cudaMalloc((void **)&_gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon));
            unsigned int seed = time(0);
            cudaEvent_t start, stop;
            cudaEventCreate(&start);
            cudaEventCreate(&stop);
            cudaEventRecord(start); 
            finalState<<<nBlocks, THREADS_PER_BLOCK>>>(seed, states, _gpuPhotons, detector, rng, tissue, NUMBER_OF_PHOTONS);
            cudaEventRecord(stop);
            cudaMemcpy(_cpuPhotons, _gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon), cudaMemcpyDeviceToHost);
            cudaEventSynchronize(stop);
            float milliseconds = 0;
            cudaEventElapsedTime(&milliseconds, start, stop);
            totalTime += milliseconds;
            cudaEventDestroy( start );
            cudaEventDestroy( stop );
            free(_cpuPhotons);
            cudaFree(_gpuPhotons);
            cudaFree(states);
        }
        std::cout << "Average = " << totalTime/NUMBER_OF_TEST_RUNS << " ms" << std::endl;
        return 0;
}