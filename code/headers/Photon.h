#ifndef PHOTON_H
#define PHOTON_H

#include "Ray.h"

class Photon
{
public:
    __device__ Photon();
    __device__ Photon(Point position);

    __device__ void setWeight(float weight);
    __device__ void setPosition(Point point);
    __device__ void setState(int state);
    __device__ float getWeight();
    __device__ __host__ Point getPosition();
    __device__ __host__ int getState();

    __device__ void terminate();
    __device__ void boost(float factor);

    __device__ void moveAlong(Ray path);

    static const int ROAMING = 1;
    static const int TERMINATED = -1;
    static const int DETECTED = 0;
    static const int ESCAPED = 2;

private:
    float _weight;
    Point _position;
    int _state;
};

#endif