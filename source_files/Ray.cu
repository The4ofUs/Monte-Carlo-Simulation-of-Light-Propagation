#include "Ray.h"


void Ray::startFrom(Point startingPoint) // Sets getYour starting point
{
    this->_currentPos.setCoordinates(startingPoint.getX(), startingPoint.getY(), startingPoint.getZ());
};

void Ray::setDirection(Point direction) { this->_direction.setCoordinates(direction.getX(), direction.getY(), direction.getZ()); }

void Ray::setStep(float step) { this->_step = step; }

Point Ray::getCurrentPos() const { return this->_currentPos; }

Point Ray::getDirection() const { return this->_direction; }

float Ray::getStep() const { return this->_step; }

void Ray::move() // The point moves in the specified direction with the given step -The function relies on member attributes that getYou should set first-
{
    float newX = this->_currentPos.getX() + (this->_direction.getX() * this->getStep());
    float newY = this->_currentPos.getY() + (this->_direction.getY() * this->getStep());
    float newZ = this->_currentPos.getZ() + (this->_direction.getZ() * this->getStep());
    this->_currentPos.setCoordinates(newX, newY, newZ);
}