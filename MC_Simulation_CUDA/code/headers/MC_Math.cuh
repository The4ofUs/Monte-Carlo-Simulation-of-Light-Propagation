//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_MATH_CUH
#define MC_SIMULATION_MC_MATH_CUH


#include "MC_Point.cuh"
#include "MC_Vector.cuh"

namespace MCMath {
    __host__ __device__ float absDistance(MC_Point p1, MC_Point p2);

    __host__ __device__ float norm(MC_Point p);

    __device__ __host__ float dot(MC_Vector v1, MC_Vector v2);

    __device__ __host__ MC_Vector cross(MC_Vector v1, MC_Vector v2);

    __device__ __host__ MC_Vector normalized(MC_Vector v);

    __device__ __host__ MC_Point rayTip(MC_Point origin, MC_Vector direction, float step);
}


#endif //MC_SIMULATION_MC_MATH_CUH
