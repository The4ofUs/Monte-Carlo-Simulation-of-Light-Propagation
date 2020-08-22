//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_FIBERGENERATOR_CUH
#define MC_SIMULATION_MC_FIBERGENERATOR_CUH


#include "MC_Point.cuh"
#include "MC_Vector.cuh"
#include "MC_Photon.cuh"
#include "MC_Path.cuh"

class MC_FiberGenerator {

public:

    __host__ MC_FiberGenerator(float radius, MC_Point center, MC_Vector normal);

    MC_FiberGenerator();

    __device__ MC_Point center();

    __device__ MC_Vector lookAt();

    __device__ bool isHit(MC_Path& path);

    __device__ MC_Point calculateIntersectionPoint(MC_Path path);

private:

    float _radius{};

    MC_Point _center{};

    MC_Vector _lookAt;
};


#endif //MC_SIMULATION_MC_FIBERGENERATOR_CUH
