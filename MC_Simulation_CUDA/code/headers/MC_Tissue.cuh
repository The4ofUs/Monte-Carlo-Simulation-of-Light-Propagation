//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_TISSUE_CUH
#define MC_SIMULATION_MC_TISSUE_CUH


#include "MC_Vector.cuh"
#include "MC_Photon.cuh"

class MC_Tissue {
public:
    MC_Tissue() = default;

    __host__ __device__ MC_Tissue(float radius, MC_Point c0, MC_Point c1, float ac, float sc, float rn);

    __device__ bool escaped(MC_Point position);

    __device__ void attenuate(MC_Photon &photon) const;

    __host__ __device__ MC_Point interface();

    __host__ __device__ MC_Point remote();

    __host__ __device__ float n() const;

    __host__ __device__ float radius() const;

    __device__ __host__ float thickness();

    __device__ __host__ float attenuationCoefficient() const;

    __host__ __device__ float absorption() const;

    __host__ __device__ float scattering() const;

private:

    float _radius;

    MC_Point _interface{};

    MC_Point _remote{};

    MC_Vector _normal{};

    float _Ms;

    float _Ma;

    float _Mt;

    float _n;
};


#endif //MC_SIMULATION_MC_TISSUE_CUH
