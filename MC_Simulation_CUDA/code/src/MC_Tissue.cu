//
// Created by mustafa on 6/3/20.
//

#include <stdexcept>
#include "../headers/MC_Tissue.cuh"
#include "../headers/MC_Math.cuh"


__host__ MC_Tissue::MC_Tissue(float const radius, MC_Point const c0, MC_Point const c1, float const ac, float const sc) {
    if (radius > 0 && ac > 0 && sc > 0) {
        this->_radius = radius;
        this->_interface = c0;
        this->_remote = c1;
        this->_normal = MCMath::normalized(MC_Vector(c0, c1));
        this->Ma = ac;
        this->Ms = sc;
        this->Mt = ac + sc;
    } else { throw std::invalid_argument("MC_Tissue::MC_Tissue : Illegal Argument!"); }
}

__device__ bool MC_Tissue::escaped(MC_Point const position) {
    MC_Point A = position;
    MC_Point B = this->_interface;
    MC_Vector C = this->_normal;
    float t =
            MCMath::dot(C, (A - B)) / MCMath::norm(C) * MCMath::norm(C);
    MC_Point P = B + C * t;
    float d = MCMath::absDistance(A, P);
    if (d > this->_radius) { return true; }
    float D = MCMath::norm(this->_remote - this->_interface);
    float E = MCMath::norm(P - this->_interface);
    if (E > D) { return true; }
    E = MCMath::norm((P - this->_remote));
    return E > D;
}

__device__ void MC_Tissue::attenuate(MC_Photon &photon) const {
    float newWeight = this->Ms * photon.weight() / this->Mt;
    photon.setWeight(newWeight);
}

__host__ __device__ MC_Point MC_Tissue::interface() {
    return this->_interface;
}

__host__ __device__ MC_Point MC_Tissue::remote() {
    return this->_remote;
}

__device__  __host__ float MC_Tissue::thickness() {
    return MCMath::absDistance(this->_interface, this->_remote);
}

__host__ __device__ float MC_Tissue::radius() const {
    return this->_radius;
}

__device__ __host__ float MC_Tissue::attenuationCoefficient() const {
    return this->Mt;
}

__host__ __device__ float MC_Tissue::absorption() const {
    return this->Ma;
}

__host__ __device__ float MC_Tissue::scattering() const {
    return this->Ms;
}
