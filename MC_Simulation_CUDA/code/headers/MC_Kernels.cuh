//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_KERNELS_CUH
#define MC_SIMULATION_MC_KERNELS_CUH

#include <curand_kernel.h>
#include "MC_Photon.cuh"
#include "MC_Detector.cuh"
#include "MC_RNG.cuh"
#include "MC_Tissue.cuh"
#include "MC_MLTissue.cuh"

namespace MCKernels {
    __global__ void
    simulate(unsigned int seed, curandState_t *states, MC_Photon *_gpuPhotons, MC_Detector detector, MC_RNG rng,
             MC_Tissue tissue, int n);

    __global__ void
    simulate(unsigned int seed, curandState_t *states, MC_Photon *_gpuPhotons, MC_Detector detector, MC_RNG rng,
             MC_MLTissue tissue, int n);
}
#endif //MC_SIMULATION_MC_KERNELS_CUH
