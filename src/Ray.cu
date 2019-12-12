#include "Ray.h"

__device__ Ray::Ray(Point rayOrigin, Vector rayDirection)
{
    this->_origin = rayOrigin;
    this->_direction = rayDirection;
}

__device__ Ray::Ray()
{
    this->_origin = Point();
    this->_direction = Vector();
}

__device__ void Ray::setDirection(Vector direction) { this->_direction = direction; }

__device__ Point Ray::getTip() const { return this->_tip; }

__device__ Vector Ray::getDirection() const { return this->_direction; }

__device__ Point Ray::getOrigin() const { return this->_origin; }

__device__ void Ray::updateRayState(Vector direction)
{
    this->_origin = this->_tip;
    this->_direction = direction;
}

__device__ void Ray::move(Vector direction, float step) // The point moves in the specified direction with the given step
{
    updateRayState(direction);
    this->_tip = this->_tip + (direction * step);
}
