#include "Ray.h"
using namespace std;
#include <iostream>

__device__ 
void Ray::startFrom(Point startingPoint)
{
    _currentPos.setCoordinates(startingPoint.getX(),
                                     startingPoint.getY(),
                                     startingPoint.getZ());
}

__device__
void Ray::setDirection(Point direction)
{
    _direction.setCoordinates(direction.getX(),
                                    direction.getY(),
                                    direction.getZ());
}

__device__
void Ray::setStep(float step)
{
    _step = step;
}

__device__
Point Ray::getCurrentPos() const
{
    return _currentPos;
}

__device__
Point Ray::getDirection() const
{
    return _direction;
}

__device__
float Ray::getStep() const
{
    return _step;
}

__device__
void Ray::move()
{
    const float newX = _currentPos.getX() + (_direction.getX() * _step);
    const float newY = _currentPos.getY() + (_direction.getY() * _step);
    const float newZ = _currentPos.getZ() + (_direction.getZ() * _step);

    _currentPos.setCoordinates(newX, newY, newZ);
}
