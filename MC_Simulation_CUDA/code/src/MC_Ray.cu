//
// Created by mustafa on 6/3/20.
//

#include "../headers/MC_Ray.cuh"
#include "../headers/MC_Math.cuh"

__device__  MC_Ray::MC_Ray(MC_Point const origin, MC_Vector const direction, float const step) {
    this->_origin = origin;
    this->_direction = MCMath::normalized(direction);
    this->_step = step;
    this->_tip = MCMath::rayTip(origin, direction, step);
}

__device__  MC_Ray::MC_Ray() {
    _origin = MC_Point();
    _direction = MC_Vector();
    _step = 0.f;
}

__device__  MC_Vector MC_Ray::direction() const { return this->_direction; }

__device__  MC_Point MC_Ray::origin() const { return this->_origin; }

__device__  MC_Point MC_Ray::getTip() const { return this->_tip; }
