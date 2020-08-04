//
// Created by mustafa on 6/3/20.
//

#include "../headers/MC_Photon.cuh"

__device__ MC_Photon::MC_Photon(MC_Point const position) {
    this->_weight = 1.f;
    this->_state = MC_Photon::ROAMING;
    this->_position = position;
}

__device__ MC_Photon::MC_Photon() {
    this->_weight = 1.f;
    this->_state = MC_Photon::ROAMING;
    this->_position = MC_Point();
}


__device__ void MC_Photon::setWeight(float const weight) { this->_weight = weight; }

__device__ void MC_Photon::setPosition(MC_Point const point) { this->_position = point; }

__device__ void MC_Photon::setState(MC_Photon::State const state) { this->_state = state; }

__device__ __host__ float MC_Photon::weight() const { return this->_weight; }

__device__ __host__ MC_Point MC_Photon::position() { return this->_position; }

__device__ __host__ MC_Photon::State MC_Photon::state() const { return this->_state; }

__device__ void MC_Photon::terminate() {
    this->_weight = 0.f;
    this->setState(MC_Photon::TERMINATED);
}

__device__ void MC_Photon::boost(float const factor) { this->_weight = this->_weight / factor; }

__device__ void MC_Photon::moveAlong(MC_Path const path) {
    this->_position = path.tip();
}
