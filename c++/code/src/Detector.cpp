#include "../headers/Detector.h"

Detector::Detector(float radius, Point center, Vector normal)
{
    if (radius > 0)
    {
        this->_radius = radius;
        this->_center = center;
        this->_normal = Mathematics::calculateNormalizedVector(normal);
    }
    else if (radius < 0)
    {
        radius = fabs(radius);
        this->_radius = radius;
        this->_center = center;
        this->_normal = Mathematics::calculateNormalizedVector(normal);
    }
}

Point Detector::getCenter() { return this->_center; }

Vector Detector::getNormal() { return this->_normal; }

bool Detector::isHit(Photon &photon, Ray path)
{
    float relative_distance = Mathematics::calculateAbsDistance(path.getTip(), this->_center);
    float rayTipAbsDistance = Mathematics::calculateAbsDistance(path.getTip());
    float rayOriginAbsDistance = Mathematics::calculateAbsDistance(path.getOrigin());
    float detectorAbsDistance = Mathematics::calculateAbsDistance(this->_center);
    if (rayTipAbsDistance >= detectorAbsDistance && rayOriginAbsDistance <= detectorAbsDistance && relative_distance < detectorAbsDistance)
    {
        Point point = calculateIntersectionPoint(path);
        float dfromc = Mathematics::calculateAbsDistance(point, this->_center);
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

Point Detector::calculateIntersectionPoint(Ray path)
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
    float t = Mathematics::calculateDotProduct(V, this->_normal) / Mathematics::calculateDotProduct(B, this->_normal);
    return A + B * t;
}
