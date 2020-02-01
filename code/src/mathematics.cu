#include "../headers/mathematics.h"

__host__ __device__ float Mathematics::calculateAbsDistance(Point p1, Point p2)
{
    return sqrtf(((p2.x() - p1.x()) * (p2.x() - p1.x()) + (p2.y() - p1.y()) * (p2.y() - p1.y()) + (p2.z() - p1.z()) * (p2.z() - p1.z())));
}

__host__ __device__ float Mathematics::calculateAbsDistance(Point p)
{
    return sqrtf(((p.x()) * (p.x()) + (p.y()) * (p.y()) + (p.z()) * (p.z())));
}

__device__ __host__ float Mathematics::calculateDotProduct(Vector v1, Vector v2)
{
    return v1.x() * v2.x() + v1.y() * v2.y() + v1.z() * v2.z();
}

__device__ __host__ Vector Mathematics::calculateCrossProduct(Vector v1, Vector v2)
{
    float X = v1.y() * v2.z() - v1.z() * v2.y();
    float Y = (-1) * v1.x() * v2.z() + v1.z() * v2.x();
    float Z = v1.x() * v2.y() - v1.y() * v2.x();
    return Vector(X, Y, Z);
}

__device__ __host__ Vector Mathematics::calculateNormalizedVector(Vector v)
{
    float norm = sqrtf((powf(v.x(), 2) + powf(v.y(), 2) + powf(v.z(), 2)));
    float xhat = v.x() / norm;
    float yhat = v.y() / norm;
    float zhat = v.z() / norm;
    return Vector(xhat, yhat, zhat);
}

// Needs to be tested
__device__ __host__ Point Mathematics::calculateRayTip(Point origin, Vector direction, float step)
{
    return (origin + direction * step);
}