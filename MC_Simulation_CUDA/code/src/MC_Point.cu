//
// Created by mustafa on 6/3/20.
//

#include "../headers/MC_Point.cuh"

__device__ __host__ MC_Point::MC_Point(float const x, float const y, float const z) {
    this->_x = x;
    this->_y = y;
    this->_z = z;
}

__device__ __host__ float MC_Point::x() const { return this->_x; }

__device__ __host__ float MC_Point::y() const { return this->_y; }

__device__ __host__ float MC_Point::z() const { return this->_z; }

__device__ __host__ MC_Point MC_Point::operator-(MC_Point const &other) const {
    float result_x = this->_x - other.x();
    float result_y = this->_y - other.y();
    float result_z = this->_z - other.z();
    return {result_x, result_y, result_z};
}

__device__ __host__ MC_Point MC_Point::operator+(MC_Point const &other) const {
    float result_x = this->_x + other.x();
    float result_y = this->_y + other.y();
    float result_z = this->_z + other.z();
    return {result_x, result_y, result_z};
}

__device__ __host__ MC_Point MC_Point::operator*(float const &other) const {
    float result_x = this->_x * other;
    float result_y = this->_y * other;
    float result_z = this->_z * other;
    return {result_x, result_y, result_z};
}