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
    static const int MAX_SIZE = 8;
public:
    enum Direction {
        UP, DOWN
    };

    __host__ MC_MLTissue(float radius, MC_Point c0, MC_Point c1, const std::vector<float> &absorpCoeffs,
                         const std::vector<float> &scatterCoeffs, const std::vector<float> &refractIndices);

    MC_MLTissue();

    __device__ float coefficient(MC_Point const position);

    __device__ void attenuate(MC_Photon &photon);

    __device__ bool escaped(MC_Path const path);

    __device__ __host__ bool isCrossing(MC_Path const path);

    __device__ __host__ int whichLayer(MC_Point position);

    __device__ void updatePath(MC_Path &path);

    __device__ __host__ bool onBoundary(MC_Path const path);

    __device__ bool isReflected(MC_Path const path, float const random);

    static __device__ void reflect(MC_Path &path, float step);

    /*
     * Citation:
     * This function was inspired by the content provided by Bram de Greve (bram.degreve@gmail.com)
     * in his notes here "https://graphics.stanford.edu/courses/cs148-10-summer/docs/2006--degreve--reflection_refraction.pdf"
     */
    __device__ void transmit(MC_Path &path, float const step);

    __device__ MC_Tissue getLayer(int const idx);

    __device__ Direction whichDirection(MC_Path const path);

    __device__ int nextLayer(int const idx, Direction const dir) const;

private:
    MC_Tissue _layers[MAX_SIZE];
    MC_Point _interface{};
    MC_Point _remote{};
    float _radius{};
    MC_Vector _normal;
    int _size{};
    float _thickness{};
    float _portion{};

    __device__ int whichBoundary(MC_Path const path);

};


#endif //MC_SIMULATION_MC_MLTISSUE_CUH
