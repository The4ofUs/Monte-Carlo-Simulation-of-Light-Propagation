#include "Ray.h"

__device__ Ray::Ray(Point rayOrigin, Vector rayDirection)
{
    this->_origin = rayOrigin;
    this->_direction = rayDirection.normalize();
}

__device__ Ray::Ray()
{
    this->_origin = Point();
    this->_direction = Vector();
}

__device__ Point Ray::getTip() const { return this->_tip; }

__device__ Vector Ray::getDirection() const { return this->_direction; }

__device__ Point Ray::getOrigin() const { return this->_origin; }
