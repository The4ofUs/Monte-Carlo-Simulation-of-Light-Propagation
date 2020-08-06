//
// Created by mustafa on 6/3/20.
//

#include "../headers/MC_Math.cuh"

__host__ __device__ float MCMath::absDistance(MC_Point const p1, MC_Point const p2)
{
    return sqrtf(((p2.x() - p1.x()) * (p2.x() - p1.x()) + (p2.y() - p1.y()) * (p2.y() - p1.y()) + (p2.z() - p1.z()) * (p2.z() - p1.z())));
}

__host__ __device__ float MCMath::norm(MC_Point const p)
{
    return sqrtf(((p.x()) * (p.x()) + (p.y()) * (p.y()) + (p.z()) * (p.z())));
}

__device__ __host__ float MCMath::dot(MC_Vector const v1, MC_Vector const v2)
{
    return v1.x() * v2.x() + v1.y() * v2.y() + v1.z() * v2.z();
}

__device__ __host__ MC_Vector MCMath::cross(MC_Vector const v1, MC_Vector const v2)
{
    float X = v1.y() * v2.z() - v1.z() * v2.y();
    float Y = (-1) * v1.x() * v2.z() + v1.z() * v2.x();
    float Z = v1.x() * v2.y() - v1.y() * v2.x();
    return {X, Y, Z};
}

__device__ __host__ MC_Vector MCMath::normalized(MC_Vector const v)
{
    float norm = sqrtf((powf(v.x(), 2) + powf(v.y(), 2) + powf(v.z(), 2)));
    float x = v.x() / norm;
    float y = v.y() / norm;
    float z = v.z() / norm;
    return {x, y, z};
}

// Needs to be tested
__device__ __host__ MC_Point MCMath::rayTip(MC_Point const origin, MC_Vector const direction, float step)
{
    return (origin + (direction * step));
}

__device__ __host__ float MCMath::point2PlaneDist(MC_Point p, MC_Point coord, MC_Vector n) {
    MC_Vector v = MC_Vector(coord, p);
    return abs(MCMath::dot(v, n));
}