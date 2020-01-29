#include "../headers/Detector.h"

__host__ Detector::Detector(float radius, Point center, Vector normal)
{
    if (radius > 0)
    {
        this->_radius = radius;
        this->_center = center;
        this->_normal = getNormalizedVector(normal);
    }
    else if (radius < 0)
    {
        radius = fabs(radius);
        this->_radius = radius;
        this->_center = center;
        this->_normal = getNormalizedVector(normal);
    }
}

__device__ Point Detector::getCenter() { return this->_center; }

__device__ Vector Detector::getNormal() { return this->_normal; }

__device__ bool Detector::isHit(Photon &photon, Ray path)
{
    float relative_distance = getAbsDistance(path.getTip(), this->_center);
    float rayTipAbsDistance = getAbsDistance(path.getTip());
    float rayOriginAbsDistance = getAbsDistance(path.getOrigin());
    float detectorAbsDistance = getAbsDistance(this->_center);
    if (rayTipAbsDistance >= detectorAbsDistance && rayOriginAbsDistance <= detectorAbsDistance && relative_distance < detectorAbsDistance)
    {
        Point point = getIntersectionPoint(path);
        float dfromc = getAbsDistance(point, this->_center);
        if (dfromc <= this->_radius)
        {
            photon.setPosition(point);
            return true;
        }
        else
            return false;
    }
    else
        return false;
}

__device__ Point Detector::getIntersectionPoint(Ray path)
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
    Point A = path.getOrigin();
    Vector B = path.getDirection();
    Vector V = Vector(A, this->_center);
    float t = getDotProduct(V, this->_normal) / getDotProduct(B, this->_normal);
    return A + B * t;
}
