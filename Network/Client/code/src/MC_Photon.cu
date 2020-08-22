//
// Created by mustafa on 6/3/20.
//

#include "../headers/MC_Photon.cuh"

__device__ MC_Photon::MC_Photon(MC_Point const position) {
    _weight = 1.f;
    _state = MC_Photon::ROAMING;
    _position = position;
}

__device__ MC_Photon::MC_Photon() {
    _weight = 1.f;
    _state = MC_Photon::ROAMING;
    _position = MC_Point();
}


__device__ void MC_Photon::setWeight(float const weight) { _weight = weight; }

__device__ void MC_Photon::setPosition(MC_Point const point) { _position = point; }

__device__ void MC_Photon::setState(MC_Photon::State const state) { _state = state; }

__device__ __host__ float MC_Photon::weight() const { return _weight; }

__device__ __host__ MC_Point MC_Photon::position() { return _position; }

__device__ __host__ MC_Photon::State MC_Photon::state() const { return _state; }

__device__ void MC_Photon::terminate() {
    _weight = 0.f;
    _state = TERMINATED;
}

__device__ void MC_Photon::boost(float const factor) { _weight = _weight / factor; }

__device__ void MC_Photon::moveAlong(MC_Path const path) {
    _position = path.tip();
}

__device__ bool MC_Photon::isRoaming() {
    return _state == ROAMING;
}

__device__ bool MC_Photon::isDying() const {
    return _weight < WEIGHT_THRESHOLD;
}
