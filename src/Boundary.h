#ifndef BOUNDARY_H
#define BOUNDARY_H

#include <cmath>
#include "Ray.h"

/**
 * @brief The Boundary class
 * Spherical Boundary class
 */
class Boundary
{

public:
    /**
 * @brief Constructor
 * @param r
 * @param c
 * r sets the radius of the spherical boundary
 * c sets the center of the spherical boundary
 */
    __device__ __host__ Boundary(float r, Point c);

    /**
 * @brief setRadius
 * @param r
 * sets the radius of the spherical boundary
 */
    __device__ void setRadius(float r);

    /**
 * @brief getRadius
 * @return the radius of the spherical boundary
 */
    __device__ float getRadius() const;

    /**
 * @brief setCenter
 * @param c
 * sets the center of the spherical boundary
 */
    __device__ void setCenter(Point c);

    /**
 * @brief getCenter
 * @return the center of the spherical boundary 
 */
    __device__ Point getCenter() const;

    /**
 * @brief isCrossed
 * @param ray
 * @return whether the Boundary was crossed by the given ray or not
 */
    __device__ bool isHit(Ray ray);

    /**
 * @brief getIntersectionPoint
 * @param ray
 * @return the intersection Point between the ray and the spherical boundary
 */
    __device__ Point getIntersectionPoint(Ray ray);

private:
    /**
 * @brief _radius
 * the radius of the spherical boundary
 */
    float _radius;

    /**
 * @brief _center
 * the center of the spherical boundary
 */
    Point _center;
};
#endif

