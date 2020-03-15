#include "../headers/Ray.h"

/** TODO: Make sure step is normalized by getting the maximum generated step from RNG
 * */
Ray::Ray(Point origin, Vector direction, float step)
{
    this->_origin = origin;
    this->_direction = Mathematics::calculateNormalizedVector(direction);
    this->_step = step;
    this->_tip = Mathematics::calculateRayTip(origin, direction, step);
}

Ray::Ray()
{
    this->_origin = Point();
    this->_direction = Vector();
}

Vector Ray::getDirection() const { return this->_direction; }

Point Ray::getOrigin() const { return this->_origin; }

float Ray::getStep() const { return this->_step; }

Point Ray::getTip() const { return this->_tip; }

void Ray::setDirection(Vector v) { this->_direction = Mathematics::calculateNormalizedVector(v); }

void Ray::setOrigin(Point p) { this->_origin = p; }

void Ray::setStep(float step)
{
    this->_step = fabs(step);
    this->_tip = this->_direction * this->_step;
}
