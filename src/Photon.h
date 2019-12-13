#ifndef PHOTON_H
#define PHOTON_H

#include "Ray.h"
#include "RNG.h"
#include "Vector.h"

class Photon : public Ray
{
public:
    __device__ Photon();
    __device__ Photon(Point rayOrigin, Vector rayDirection);
    __device__ void roulette(RNG rng, curandState *globalState, int i);
    __device__ float weight();
    __device__ __host__ Point position();
    __device__ void move(Vector direction, float step);
    __device__ void updateState(Vector direction);
    __device__ void setPosition(Point point);
    __device__ void setState(int state);
    static const int ROAMING = 1;
    static const int TERMINATED = -1;
    static const int DETECTED = 0;

private:
    float _weight;
    Point _position;
    int _state;

    __device__ void terminate();
    __device__ void boost();
};

#endif