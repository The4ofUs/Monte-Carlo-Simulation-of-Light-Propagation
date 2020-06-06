//
// Created by mustafa on 6/3/20.
//

#include "../headers/MC_Vector.cuh"

__device__ __host__ MC_Vector::MC_Vector() {
    _x = 0.f;
    _y = 0.f;
    _z = 0.f;
}

__device__ __host__ MC_Vector::MC_Vector(MC_Point const point) {
    this->_x = point.x();
    this->_y = point.y();
    this->_z = point.z();
}

__device__ __host__ MC_Vector::MC_Vector(float const x, float const y, float const z) {
    this->_x = x;
    this->_y = y;
    this->_z = z;
}

__device__ __host__ MC_Vector::MC_Vector(MC_Point const point1, MC_Point const point2) {
    this->_x = point2.x() - point1.x();
    this->_y = point2.y() - point1.y();
    this->_z = point2.z() - point1.z();
}