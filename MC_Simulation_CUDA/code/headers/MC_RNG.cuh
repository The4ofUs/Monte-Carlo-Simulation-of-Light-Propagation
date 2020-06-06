//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_RNG_CUH
#define MC_SIMULATION_MC_RNG_CUH


#include <curand_kernel.h>
#include "MC_Point.cuh"
#include "MC_Photon.cuh"

class MC_RNG {
public:
    static __device__ float generate(curandState *states, int i);

    static __device__ float getRandomStep(curandState *states, int i);

    static __device__ MC_Vector getRandomDirection(curandState *states, int i);

    static __device__ MC_Point getRandomPoint(curandState *states, int i);

    static __device__ void roulette(MC_Photon &photon, float chance, curandState *globalState, int i);
};


#endif //MC_SIMULATION_MC_RNG_CUH
