#ifndef MATHEMATICS_H
#define MATHEMATICS_H
#include "Vector.h"

namespace Mathematics
{

__host__ __device__ float calculateAbsDistance(Point p1, Point p2);

__host__ __device__ float calculateAbsDistance(Point p);

__device__ __host__ float calculateDotProduct(Vector v1, Vector v2);

__device__ __host__ Vector calculateCrossProduct(Vector v1, Vector v2);

__device__ __host__ Vector calculateNormalizedVector(Vector v);

// Needs to be tested
__device__ __host__ Point calculateRayTip(Point origin, Vector direction, float step);
} // namespace Mathematics
#endif
