#ifndef BOUNDARY_H
#define BOUNDARY_H

#include <cmath>
#include "Ray.h"

/**
 * @brief The Boundary class
 * Spherical Boundary class
 */
class Boundary {

public:

static int const SPHERICAL = 0;
static int const CYLINDRICAL = 1;


/**
 * @brief Constructor
 * @param r
 * @param c
 * r sets the radius of the spherical boundary
 * c sets the center of the spherical boundary
 */
 __device__ __host__ Boundary(float r, Point c);

 /**
 * @brief Constructor
 * @param r
 * @param c
 * @param ax
 * @param h
 * r sets the radius of the spherical boundary
 * c sets the center of the spherical boundary
 * ax is a point representing the axis line
 * h represents the cylindrical boundary height
 */
 __device__ __host__ Boundary(float r, Point c, Point ax, float h);

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
 * @brief _shape
 * the shape of the boundary
 * 0 : Spherical boundary
 * 1 : Cylindrical boundary
 */
const int _shape;

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


/**
 * @brief _axis
 * the axis of the cylindrical boundary
 */
Point _axis;


/**
 * @brief _height
 * the height of the cylindrical boundary
 */
float _height;

/**
 * @brief dotProduct
 * @param point1
 * @param point2
 * @return Dot Product
 */
__device__ float dot(Point point1, Point point2);

};
#endif




/**
 *  R0 = Ray's origin (Prev Position)
 *  Rd = The direction of the ray (Ray's Direction)
 *  t = this is the intersection distance from the ray origin to the hit point 
 *  t = dot((CenterOfTheSphere - R0), Rd)
 *  x = sqrt(r^2 - y^2)
 *  y = length(S - P)
 *  where S is the center of the sphere, P is anypoint on the Ray
 *  t1 = t+x
 *  t2 = t-x
 *  pointOfIntersection = RayOrigin + direction*t
 */
