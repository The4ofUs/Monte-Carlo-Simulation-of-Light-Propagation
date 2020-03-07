#include "../headers/Photon.h"

Photon::Photon()
{
    this->_weight = 1.f;
    this->_state = this->ROAMING;
}

Photon::Photon(Point position)
{
    this->_weight = 1.f;
    this->_state = this->ROAMING;
    this->_position = position;
}

void Photon::setWeight(float weight) { this->_weight = weight; }

void Photon::setPosition(Point point) { this->_position = point; }

void Photon::setState(short state) { this->_state = state; }

float Photon::getWeight() { return this->_weight; }

Point Photon::getPosition() { return this->_position; }

short Photon::getState() { return this->_state; }

unsigned int Photon::getLifetime() { return this->lifetime; }

void Photon::incrementLifetime(){ this->lifetime++; }

void Photon::terminate()
{
    this->_weight = 0.f;
    this->setState(this->TERMINATED);
}
void Photon::boost(float factor) { this->_weight = this->_weight / factor; }

void Photon::moveAlong(Ray path) // The photon moves in the specified direction with the given step
{
    this->_position = path.getTip();
}
