#include "Ray.h"
using namespace std;

__device__ Ray::Ray(Point rayOrigin, Vector rayDirection){
    this->_origin = rayOrigin;
    this->_direction = rayDirection;
}

__device__ void Ray::setDirection(Vector direction) { this->_direction = direction; }

__device__ void Ray::setStep(float step) { this->_step = step; }

__device__ Point Ray::getCurrent() const { return this->_current; }

__device__ Vector Ray::getDirection() const { return this->_direction; }

__device__ Point Ray::getOrigin() const { return this->_origin; }

__device__ float Ray::getStep() const { return this->_step; }

__device__ void Ray::updateRayState(Vector direction, float step){
    this->_origin = this->_current;
    this->_direction = direction;
    this->_step = step;
}

__device__ void Ray::move(Vector direction, float step) // The point moves in the specified direction with the given step
{
    updateRayState(direction, step);
    this->_current = this->_current + (direction * step);
}
