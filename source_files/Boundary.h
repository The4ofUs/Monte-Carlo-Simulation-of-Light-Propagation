#include <cmath>
#include "Point.h"
#include "Ray.h"

class Boundary {

private:

float radius;
Point center;
Point intersectionPoint;

__device__
float dotProduct(Point point1, Point point2);

__device__
void swap(float &num1, float &num2);

public:

 __device__ Boundary(float r, Point c);

__device__ void setRadius(float r);

__device__ float getRadius() const;

__device__ void setCenter(Point c);

__device__ Point getCenter() const;

__device__ bool isCrossed(Ray ray);

__device__ Point getIntersectionPoint(Ray ray);

};





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
