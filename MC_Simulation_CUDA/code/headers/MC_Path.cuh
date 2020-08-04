//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_PATH_CUH
#define MC_SIMULATION_MC_PATH_CUH


#include "MC_Point.cuh"
#include "MC_Vector.cuh"

class MC_Path {
public:
    __device__ MC_Path(MC_Point origin, MC_Vector direction, float step);

    __device__ MC_Path();

    __device__  MC_Point tip() const;

    __device__  MC_Vector direction() const;

    __device__  MC_Point origin() const;

    __device__ void setTip(MC_Point newTip);


protected:

    MC_Point _origin;

    MC_Point _tip;

    float _step;

    MC_Vector _direction;
};


#endif //MC_SIMULATION_MC_PATH_CUH
