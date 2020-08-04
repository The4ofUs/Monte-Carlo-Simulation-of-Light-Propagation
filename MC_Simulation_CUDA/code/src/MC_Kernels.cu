//
// Created by mustafa on 6/3/20.
//

#include "../headers/MC_Kernels.cuh"
#include "../headers/MC_RandomWalk.cuh"

__global__ void MCKernels::simulate(unsigned int seed, curandState_t *states, MC_Photon *_gpuPhotons, MC_Detector const detector,
                    MC_RNG const rng,
                    MC_MLTissue tissue, int const n) {
    int idx = (int) (blockIdx.x * blockDim.x + threadIdx.x);
    if (idx < n) {
        curand_init(seed, idx, 0, &states[idx]);
        MC_Photon finalState = RandomWalk(states, idx, detector, rng, tissue);
        _gpuPhotons[idx] = finalState;
    }
}

