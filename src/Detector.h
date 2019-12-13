#ifndef DETECTOR_H
#define DETECTOR_H

#include "Point.h"
#include "Vector.h"
#include "Ray.h"
#include "Photon.h"

class Detector
{

public:
    __host__ Detector(float radius, Point center, Vector normal);
    __device__ bool isHit(Photon photon);
    __device__ Point getIntersectionPoint(Photon photon);
    __device__ float getAbsDistance();

private:
    float _radius;
    float _distance;
    Point _center;
    Vector _normal;
};
#endif