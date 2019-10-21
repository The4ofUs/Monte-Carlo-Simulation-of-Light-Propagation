#ifndef POINT_H
#define POINT_H

// CUDA utilities
#include <helper_cuda.h>
//#include <helper_cuda_gl.h>

// Helper functions
#include <helper_functions.h>
#include <helper_timer.h>

#include <stdint.h>
#include <cuda_runtime.h>
#include <cuda_gl_interop.h>
#include <vector_types.h>
#include <vector_functions.h>
#include <driver_functions.h>

// (x,y,z)
class Point
{

public:
    __host__ __device__
    void setCoordinates(float x, float y, float z);
    float getX() const;
    float getY() const;
    float getZ() const;

private:
    float _x;
    float _y;
    float _z;
};

#endif 