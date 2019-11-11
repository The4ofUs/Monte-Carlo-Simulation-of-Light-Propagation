#include "Ray.h"
using namespace std;
#include <iostream>


__device__ void Ray::setDirection(Point direction) { this->_direction.setCoordinates(direction.getX(), direction.getY(), direction.getZ()); }

__device__ void Ray::setStep(float step) { this->_step = step; }

__device__ Point Ray::getCurrentPos() const { return this->_currentPos; }

__device__ Point Ray::getDirection() const { return this->_direction; }

__device__ Point Ray::getPrevPos() const { return this->_prevPos; }

__device__ float Ray::getStep() const { return this->_step; }

__device__ void Ray::move() // The point moves in the specified direction with the given step
{
    this->_prevPos = this->_currentPos;
    float newX = this->_currentPos.getX() + (this->_direction.getX() * this->getStep());
    float newY = this->_currentPos.getY() + (this->_direction.getY() * this->getStep());
    float newZ = this->_currentPos.getZ() + (this->_direction.getZ() * this->getStep());
    this->_currentPos.setCoordinates(newX, newY, newZ);
}
