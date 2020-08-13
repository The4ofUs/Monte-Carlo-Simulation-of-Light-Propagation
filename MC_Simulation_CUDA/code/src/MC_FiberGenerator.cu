//
// Created by mustafa on 6/3/20.
//

#include <stdexcept>

#include "../headers/MC_FiberGenerator.cuh"
#include "../headers/MC_Math.cuh"


__host__ MC_FiberGenerator::MC_FiberGenerator(float const radius, MC_Point const center, MC_Vector const lookAt) {
    if (radius > 0) {
        _radius = radius;
        _center = center;
        _lookAt = MCMath::normalized(lookAt);
    } else {
        throw std::invalid_argument("MC_FiberGenerator::MC_FiberGenerator : Illegal Argument!");
    }
}

__device__ MC_Point MC_FiberGenerator::center() { return _center; }

__device__ MC_Vector MC_FiberGenerator::lookAt() { return _lookAt; }

__device__ bool MC_FiberGenerator::isHit(MC_Path &path) {
    float relative_distance = MCMath::absDistance(path.tip(), _center);
    float rayTipAbsDistance = MCMath::norm(path.tip());
    float rayOriginAbsDistance = MCMath::norm(path.origin());
    float detectorAbsDistance = MCMath::norm(_center);
    if (rayTipAbsDistance >= detectorAbsDistance && rayOriginAbsDistance <= detectorAbsDistance &&
        relative_distance < detectorAbsDistance) {
        MC_Point point = calculateIntersectionPoint(path);
        float d_c = MCMath::absDistance(point, _center);
        if (d_c <= _radius) {
            path.setTip(point);
            return true;
        }
    }
    return false;
}


__device__ MC_Point MC_FiberGenerator::calculateIntersectionPoint(MC_Path const path) {
    MC_Point A = path.origin();
    MC_Vector B = path.direction();
    MC_Vector V = MC_Vector(A, _center);
    float t = MCMath::dot(V, _lookAt) / MCMath::dot(B, _lookAt);
    return A + B * t;
}

MC_FiberGenerator::MC_FiberGenerator() =
default;
