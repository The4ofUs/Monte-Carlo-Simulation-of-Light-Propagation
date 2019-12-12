#ifndef PHOTON_H
#define PHOTON_H

#include "Ray.h"
#include "RNG.h"

class Photon : public Ray
{
public:
    __device__ Photon();
    __device__ Photon(Point rayOrigin, Vector rayDirection);
    __device__ void roulette(RNG rng, curandState *globalState, int i);
    __device__ float getWeight();

private:
    float _weight;
    Point _position;

    __device__ void terminate();
    __device__ void boost();
};

#endif