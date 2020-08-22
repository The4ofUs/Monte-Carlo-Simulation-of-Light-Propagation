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

 void Photon::setWeight(double weight) { this->_weight = weight; }

 void Photon::setPosition(Point point) { this->_position = point; }

 void Photon::setState(long state) { this->_state = state; }

 double Photon::getWeight() { return this->_weight; }

 Point Photon::getPosition() { return this->_position; }

 long Photon::getState() { return this->_state; }

 void Photon::terminate()
{
    this->_weight = 0.f;
    this->setState(this->TERMINATED);
}
