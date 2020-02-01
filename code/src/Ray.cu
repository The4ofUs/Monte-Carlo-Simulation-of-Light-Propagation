#include "../headers/Ray.h"

/** TODO: Make sure step is normalized by getting the maximum generated step from RNG
 * */
__device__ __host__ Ray::Ray(Point origin, Vector direction, float step)
{
    this->_origin = origin;
    this->_direction = Mathematics::calculateNormalizedVector(direction);
    this->_step = step;
    this->_tip = Mathematics::calculateRayTip(origin, direction, step);
}

__device__ __host__ Ray::Ray()
{
    this->_origin = Point();
    this->_direction = Vector();
}

__device__ __host__ Vector Ray::getDirection() const { return this->_direction; }

__device__ __host__ Point Ray::getOrigin() const { return this->_origin; }

__device__ __host__ float Ray::getStep() const { return this->_step; }

__device__ __host__ Point Ray::getTip() const { return this->_tip; }

__device__ __host__ void Ray::setDirection(Vector v) { this->_direction = Mathematics::calculateNormalizedVector(v); }

__device__ __host__ void Ray::setOrigin(Point p) { this->_origin = p; }

__device__ __host__ void Ray::setStep(float step)
{
    this->_step = fabs(step);
    this->_tip = this->_direction * this->_step;
}
