#include "Ray.h"
using namespace std;

__device__ Ray::Ray(Point startingPoint, Point direction){
    this->_currentPos.setCoordinates(startingPoint.x(), startingPoint.y(), startingPoint.z());
    this->_direction.setCoordinates(direction.x(), direction.y(), direction.z());
}

__device__ void Ray::setDirection(Point direction) { this->_direction.setCoordinates(direction.x(), direction.y(), direction.z()); }

__device__ void Ray::setStep(float step) { this->_step = step; }

__device__ Point Ray::getCurrentPos() const { return this->_currentPos; }

__device__ Point Ray::getDirection() const { return this->_direction; }

__device__ Point Ray::getPrevPos() const { return this->_prevPos; }

__device__ float Ray::getStep() const { return this->_step; }

__device__ void Ray::updateRayState(Point direction, float step){
    this->_prevPos = this->_currentPos;
    this->_direction = direction;
    this->_step = step;
}

__device__ void Ray::move(Point direction, float step) // The point moves in the specified direction with the given step
{
    updateRayState(direction, step);
    this->_currentPos = this->_currentPos + (direction * step);
}
