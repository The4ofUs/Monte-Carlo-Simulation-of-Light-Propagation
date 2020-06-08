//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_POINT_CUH
#define MC_SIMULATION_MC_POINT_CUH
#include <curand.h>
#include <curand_kernel.h>

class MC_Point {

public:

    __device__ __host__ MC_Point(float x, float y, float z);

    MC_Point() = default;

    __device__  __host__ float x() const;

    __device__  __host__ float y() const;

    __device__  __host__ float z() const;

    __device__ __host__ MC_Point operator+(MC_Point const &other) const;

    __device__ __host__ MC_Point operator-(MC_Point const &other) const;

    __device__ __host__ MC_Point operator*(float const &other) const;

protected:
    float _x;
    float _y;
    float _z;
};


#endif //MC_SIMULATION_MC_POINT_CUH
