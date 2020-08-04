//
// Created by mustafa on 6/4/20.
//

#ifndef MC_SIMULATION_MC_MLTISSUE_CUH
#define MC_SIMULATION_MC_MLTISSUE_CUH


#include <vector>
#include "MC_Point.cuh"
#include "MC_Photon.cuh"
#include "MC_Tissue.cuh"

class MC_MLTissue {
public:
    __host__ MC_MLTissue(float radius, MC_Point c0, MC_Point c1, const std::vector<float> &absorpCoeffs,
                         const std::vector<float> &scatterCoeffs);

    MC_MLTissue();

    __device__ float coefficient(MC_Point position);

    __device__ void attenuate(MC_Photon &photon);

    __device__ bool escaped(MC_Point position);

    __device__ bool isCrossing(MC_Ray path);

    __device__ int size() const;

    __device__ MC_Tissue whichLayer(MC_Point position);

private:
    static const int MAX_SIZE = 8;
    MC_Tissue _layers[MAX_SIZE];
    MC_Point _interface{};
    MC_Point _remote{};
    float _radius{};
    MC_Vector _normal;
    int _size{};
    float _thickness{};
};


#endif //MC_SIMULATION_MC_MLTISSUE_CUH
