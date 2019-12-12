#include "Photon.h"
#include "RNG.h"
#define WEIGHT_THRESHOLD 0.0001f
#define ROULETTE_CHANCE 0.1f

__device__ Photon::Photon()
{
    this->_weight = 1.f;
}

__device__ Photon::Photon(Point rayOrigin, Vector rayDirection)
{
    this->_origin = rayOrigin;
    this->_position = rayOrigin;
    this->_direction = rayDirection;
    this->_weight = 1.f;
}

__device__ void Photon::roulette(RNG rng, curandState *globalState, int i)
{
    if (rng.generate(globalState, i) < ROULETTE_CHANCE)
    {
        this->terminate();
    }
    else
    {
        this->boost();
    }
}

__device__ float Photon::weight()
{
    return this->_weight;
}

__device__ __host__ Point Photon::position()
{
    return this->_position;
}

__device__ void Photon::setPosition(Point point)
{
    this->_position = point;
}

__device__ void Photon::terminate()
{
    this->_weight = 0.f;
}
__device__ void Photon::boost()
{
    this->_weight = this->_weight / ROULETTE_CHANCE;
}

__device__ void Photon::updateState(Vector direction)
{
    this->_origin = this->_tip;
    this->_direction = direction;
}

__device__ void Photon::move(Vector direction, float step) // The photon moves in the specified direction with the given step
{
    updateState(direction);
    this->_tip = this->_tip + (direction * step);
    this->_position = this->_tip;
}
