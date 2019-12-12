#include "Detector.h"
#include "Point.h"
#include "RNG.h"
#include <math.h>

__host__ Detector::Detector(float radius, Point center, Vector normal)
{
    if (radius > 0)
    {
        this->_radius = radius;
        this->_center = center;
        this->_normal = normal.normalize();
        this->_distance = center.getAbsDistance();
    }
    else
    {
        radius = fabs(radius);
        this->_radius = radius;
        this->_center = center;
        this->_normal = normal.normalize();
        this->_distance = center.getAbsDistance();
    }
};

__device__ float Detector::getAbsDistance()
{
    return this->_distance;
}

__device__ bool Detector::isHit(Ray ray)
{
    float rayAbsDistance = ray.getTip().getAbsDistance();
    float rayOriginAbsDistance = ray.getOrigin().getAbsDistance();
    if (rayAbsDistance >= this->_distance && rayOriginAbsDistance <= this->_distance)
    {
        Point point = this->getIntersectionPoint(ray);
        float dfromc = point.getAbsDistance(this->_center);
        if (dfromc <= this->_radius)
        {
            return true;
        }
        else
            return false;
    }
    else
        return false;
}

__device__ Point Detector::getIntersectionPoint(Ray ray)
{
    /**
        P is a point on the ray
        A is the ray's origin
        B is the direction of the ray
        let's assume that P is on the detector's plane
        We know that P = A + B*t    (1)
        where t is a parameter that determines how far the ray will move in direction B
        (P - Center) will yield a vector on the plane
        so (P - Center).normal = 0  (2)
        now substitute from (1) in (2)
        we will yield an equation with t as the unknown
        we calculate t and substitute in the ray's equation to get the intersection point
        and Voila
    */
    Point A = ray.getOrigin();
    Vector B = ray.getDirection();
    Vector V = (this->_center - A);
    float t = V.dot(this->_normal) / (B.dot(this->_normal));
    return A + B * t;
}
