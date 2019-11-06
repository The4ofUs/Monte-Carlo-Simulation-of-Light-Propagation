#ifndef POINT_H
#define POINT_H

#include <helper_cuda.h>


#include <helper_functions.h>
#include <helper_timer.h>

// (x,y,z)
class Point
{

public:
__device__ Point(){setCoordinates(0.f , 0.f, 0.f);}
__device__
    void setCoordinates(float x, float y, float z);
__device__ __host__
    float getX() const;
__device__ __host__
    float getY() const;
__device__ __host__
    float getZ() const;

private:
    float _x;
    float _y;
    float _z;
};

#endif 