#ifndef RNG_H
#define RNG_H

#include "Photon.h"
#include "common.h"
/**
 * @brief The RNG class
 * Pseudo Random Number Generator
 */
class RNG
{
public:
    __device__ float generate(curandState *states, int i);

    __device__ float getRandomStep(curandState *states, int i);

    __device__ Vector getRandomDirection(curandState *states, int i);

    __device__ Point getRandomPoint(curandState *states, int i);

    __device__ void roulette(Photon &photon, float chance, curandState *globalState, int i);
};
#endif