#ifndef VECTOR_H
#define VECTOR_H

#include "Point.h"

class Vector : public Point
{
public:
    __device__ __host__ Vector();

    __device__ __host__ Vector(float x, float y, float z);

    __device__ __host__ Vector(Point point);

    __device__ __host__ Vector(Point point1, Point point2);
};
#endif