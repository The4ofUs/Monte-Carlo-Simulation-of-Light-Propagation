//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_DETECTOR_CUH
#define MC_SIMULATION_MC_DETECTOR_CUH


#include "MC_Point.cuh"
#include "MC_Vector.cuh"
#include "MC_Photon.cuh"
#include "MC_Ray.cuh"

class MC_Detector {

public:

    __host__ MC_Detector(float radius, MC_Point center, MC_Vector normal);

    MC_Detector();

    __device__ float radius() const;

    __device__ MC_Point center();

    __device__ MC_Vector lookAt();

    __device__ bool isHit(MC_Photon &photon, MC_Ray path);

    __device__ MC_Point calculateIntersectionPoint(MC_Ray path);

private:

    float _radius{};

    MC_Point _center{};

    MC_Vector _lookAt;
};


#endif //MC_SIMULATION_MC_DETECTOR_CUH
