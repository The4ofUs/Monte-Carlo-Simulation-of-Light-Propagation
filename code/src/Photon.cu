#include "../headers/Photon.h"

__device__ Photon::Photon()
{
    this->_weight = 1.f;
    this->_state = this->ROAMING;
}

__device__ Photon::Photon(Point position)
{
    this->_weight = 1.f;
    this->_state = this->ROAMING;
    this->_position = position;
}

__device__ void Photon::setWeight(float weight) { this->_weight = weight; }

__device__ void Photon::setPosition(Point point) { this->_position = point; }

__device__ void Photon::setState(int state) { this->_state = state; }

__device__ __host__ float Photon::getWeight() { return this->_weight; }

__device__ __host__ Point Photon::getPosition() { return this->_position; }

__device__ __host__ int Photon::getState() { return this->_state; }

__device__ void Photon::terminate()
{
    this->_weight = 0.f;
    this->setState(this->TERMINATED);
}
__device__ void Photon::boost(float factor) { this->_weight = this->_weight / factor; }

__device__ void Photon::moveAlong(Ray path) // The photon moves in the specified direction with the given step
{
    this->_position = path.getTip();
}
