//
// Created by mustafa on 6/3/20.
//

#include <stdexcept>

#include "../headers/MC_Detector.cuh"
#include "../headers/MC_Math.cuh"


__host__ MC_Detector::MC_Detector(float const radius, MC_Point const center, MC_Vector const lookAt) {
    if (radius > 0) {
        this->_radius = radius;
        this->_center = center;
        this->_lookAt = MCMath::normalized(lookAt);
    } else {
        throw std::invalid_argument("MC_Detector::MC_Detector : Illegal Argument!");
    }
}

__device__ MC_Point MC_Detector::center() { return this->_center; }

__device__ MC_Vector MC_Detector::lookAt() { return this->_lookAt; }

__device__ bool MC_Detector::isHit(MC_Photon &photon, MC_Path const path) {
    float relative_distance = MCMath::absDistance(path.tip(), this->_center);
    float rayTipAbsDistance = MCMath::norm(path.tip());
    float rayOriginAbsDistance = MCMath::norm(path.origin());
    float detectorAbsDistance = MCMath::norm(this->_center);
    if (rayTipAbsDistance >= detectorAbsDistance && rayOriginAbsDistance <= detectorAbsDistance &&
        relative_distance < detectorAbsDistance) {
        MC_Point point = calculateIntersectionPoint(path);
        float d_c = MCMath::absDistance(point, this->_center);
        if (d_c <= this->_radius) {
            photon.setPosition(point);
            return true;
        } else
            return false;
    } else
        return false;
}

__device__ MC_Point MC_Detector::calculateIntersectionPoint(MC_Path const path) {
    MC_Point A = path.origin();
    MC_Vector B = path.direction();
    MC_Vector V = MC_Vector(A, this->_center);
    float t = MCMath::dot(V, this->_lookAt) / MCMath::dot(B, this->_lookAt);
    return A + B * t;
}

MC_Detector::MC_Detector() = default;
