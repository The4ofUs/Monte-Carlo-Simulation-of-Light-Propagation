//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_VECTOR_CUH
#define MC_SIMULATION_MC_VECTOR_CUH


#include "MC_Point.cuh"

class MC_Vector: public MC_Point {
public:
    __device__ __host__ MC_Vector();

    __device__ __host__ MC_Vector(float x, float y, float z);

    __device__ __host__ MC_Vector(MC_Point point1, MC_Point point2);

    __device__ __host__ MC_Vector(MC_Point point);

};


#endif //MC_SIMULATION_MC_VECTOR_CUH
