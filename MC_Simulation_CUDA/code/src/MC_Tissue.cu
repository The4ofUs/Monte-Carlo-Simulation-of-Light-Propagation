//
// Created by mustafa on 6/3/20.
//

#include <stdexcept>
#include "../headers/MC_Tissue.cuh"
#include "../headers/MC_Math.cuh"


__host__ __device__ MC_Tissue::MC_Tissue(float const radius, MC_Point const c0, MC_Point const c1, float const ac, float const sc, float rn) {
    if (radius > 0 && ac > 0 && sc > 0 && rn > 0) {
        _radius = radius;
        _interface = c0;
        _remote = c1;
        _normal = MCMath::normalized(MC_Vector(c0, c1));
        _Ma = ac;
        _Ms = sc;
        _Mt = ac + sc;
        _n = rn;
    }
}

__device__ bool MC_Tissue::escaped(MC_Point const position) {
    MC_Point A = position;
    MC_Point B = _interface;
    MC_Vector C = _normal;
    float t = MCMath::dot(C, (A - B)) / MCMath::norm(C) * MCMath::norm(C);
    MC_Point P = B + C * t;
    float d = MCMath::absDistance(A, P);
    if (d > _radius) { return true; }
    float D = MCMath::norm(_remote - _interface);
    float E = MCMath::norm(P - _interface);
    if (E > D) { return true; }
    E = MCMath::norm((P - _remote));
    return E > D;
}

__device__ void MC_Tissue::attenuate(MC_Photon &photon) const {
    float newWeight = _Ms * photon.weight() / _Mt;
    photon.setWeight(newWeight);
}

__host__ __device__ MC_Point MC_Tissue::interface() {
    return _interface;
}

__host__ __device__ MC_Point MC_Tissue::remote() {
    return _remote;
}

__device__  __host__ float MC_Tissue::thickness() {
    return MCMath::absDistance(_interface, _remote);
}

__host__ __device__ float MC_Tissue::radius() const {
    return _radius;
}

__device__ __host__ float MC_Tissue::attenuationCoefficient() const {
    return _Mt;
}

__host__ __device__ float MC_Tissue::absorption() const {
    return _Ma;
}

__host__ __device__ float MC_Tissue::scattering() const {
    return _Ms;
}

__host__ __device__ float MC_Tissue::n() const {
    return _n;
}
