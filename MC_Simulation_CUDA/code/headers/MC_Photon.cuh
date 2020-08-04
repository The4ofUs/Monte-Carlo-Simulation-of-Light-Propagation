//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_PHOTON_CUH
#define MC_SIMULATION_MC_PHOTON_CUH


#include "MC_Point.cuh"
#include "MC_Path.cuh"

class MC_Photon {
public:
    enum State {
        ROAMING, TERMINATED, DETECTED, ESCAPED
    };

    __device__ MC_Photon();

    __device__ explicit MC_Photon(MC_Point position);

    __device__ void setWeight(float weight);

    __device__ void setPosition(MC_Point point);

    __device__ void setState(State state);

    __device__ __host__ float weight() const;

    __device__ __host__ MC_Point position();

    __device__ __host__ State state() const;

    __device__ void terminate();

    __device__ void boost(float factor);

    __device__ void moveAlong(MC_Path path);


private:
    float _weight;
    MC_Point _position;
    State _state;
};


#endif //MC_SIMULATION_MC_PHOTON_CUH
