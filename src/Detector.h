#ifndef DETECTOR_H
#define DETECTOR_H

#include "Point.h"
#include "Vector.h"
#include "Ray.h"

class Detector
{

public:
    __host__ Detector(float radius, Point center, Vector normal);
    __device__ bool isHit(Ray ray);
    __device__ Point getIntersectionPoint(Ray ray);
    __device__ float getAbsDistance();

private:
    float _radius;
    float _distance;
    Point _center;
    Vector _normal;
};
#endif