//
// Created by mustafa on 6/3/20.
//

#include "../headers/MC_Path.cuh"
#include "../headers/MC_Math.cuh"

__device__  __host__ MC_Path::MC_Path(MC_Point const origin, MC_Vector const direction, float const step) {
    _origin = origin;
    _direction = MCMath::normalized(direction);
    _step = step;
    _tip = MCMath::rayTip(origin, direction, step);
}

__device__  MC_Path::MC_Path() {
    _origin = MC_Point();
    _direction = MC_Vector();
    _step = 0.f;
}

__device__ __host__ MC_Vector MC_Path::direction() const { return _direction; }

__device__ __host__ MC_Point MC_Path::origin() const { return _origin; }

__device__ __host__ MC_Point MC_Path::tip() const { return _tip; }

__device__ void MC_Path::setTip(MC_Point newTip) { _tip = newTip; }

__device__ void MC_Path::setDirection(MC_Vector newDirection) {
    _direction = newDirection;
}

