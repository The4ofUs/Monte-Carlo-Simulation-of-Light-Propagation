//
// Created by mustafa on 6/3/20.
//

#include "../headers/MC_RNG.cuh"
#include "../headers/MC_Math.cuh"

__device__ float MC_RNG::generate(curandState *globalState, int const i) {
    curandState localState = globalState[i];
    float random = curand_uniform(&localState);
    globalState[i] = localState;
    return random;
}

__device__ float MC_RNG::getRandomNumber(curandState *states, int i) {
    float step;
    step = generate(states, i);
    return step;
}

__device__ MC_Vector MC_RNG::getRandomDirection(curandState *globalState, int const i) {
    float u = generate(globalState, i);
    float v = generate(globalState, i);

    float theta = 2 * (float) M_PI * u;
    float phi = acos(1 - 2 * v);

    // Transforming into the cartesian space
    float x = sin(phi) * cos(theta);
    float y = sin(phi) * sin(theta);
    float z = cos(phi);

    return MCMath::normalized(MC_Vector(x, y, z));
}

__device__ MC_Point MC_RNG::getRandomPoint(curandState *globalState, int const i) {
    float u = generate(globalState, i);
    float v = generate(globalState, i);

    float theta = 2 * (float) M_PI * u;
    float phi = acos(1 - 2 * v);

    // Transforming into the cartesian space
    float x = sin(phi) * cos(theta);
    float y = sin(phi) * sin(theta);
    float z = cos(phi);

    return {x, y, z};
}

__device__ void MC_RNG::roulette(MC_Photon &photon, float const chance, curandState *globalState, int const i) {
    if (generate(globalState, i) >= chance) {
        photon.terminate();
    } else {
        photon.boost(chance);
    }
}

__device__ float MC_RNG::getRandomStep(curandState *states, int i, float coefficient) {
    return ((-1 * log(MC_RNG::getRandomNumber(states, i))) / coefficient);
}

__device__ MC_Path MC_RNG::getRandomPath(curandState *states, int i, MC_Point origin, float coefficient) {
    return {origin, MC_RNG::getRandomDirection(states, i),
            MC_RNG::getRandomStep(states, i, coefficient)};
}
