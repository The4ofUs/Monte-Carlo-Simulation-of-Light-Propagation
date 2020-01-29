#ifndef DETECTOR_H
#define DETECTOR_H

#include "Photon.h"

class Detector
{

public:
    __host__ Detector(float radius, Point center, Vector normal);
    __device__ Point getCenter();
    __device__ Vector getNormal();
    __device__ bool isHit(Photon &photon, Ray path);
    __device__ Point getIntersectionPoint(Ray path);

private:
    float _radius;
    Point _center;
    Vector _normal;
};
#endif