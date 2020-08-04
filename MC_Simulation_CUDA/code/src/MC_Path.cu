//
// Created by mustafa on 6/3/20.
//

#include "../headers/MC_Path.cuh"
#include "../headers/MC_Math.cuh"

__device__  MC_Path::MC_Path(MC_Point const origin, MC_Vector const direction, float const step) {
    this->_origin = origin;
    this->_direction = MCMath::normalized(direction);
    this->_step = step;
    this->_tip = MCMath::rayTip(origin, direction, step);
}

__device__  MC_Path::MC_Path() {
    _origin = MC_Point();
    _direction = MC_Vector();
    _step = 0.f;
}

__device__  MC_Vector MC_Path::direction() const { return this->_direction; }

__device__  MC_Point MC_Path::origin() const { return this->_origin; }

__device__  MC_Point MC_Path::tip() const { return this->_tip; }

__device__ void MC_Path::setTip(MC_Point newTip) { _tip = newTip; }

