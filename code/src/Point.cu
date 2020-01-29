#include "../headers/Point.h"

__device__ __host__
Point::Point(float x, float y, float z)
{
    setCoordinates(x, y, z);
}

__device__ __host__
Point::Point()
{
    setCoordinates(0.f, 0.f, 0.f);
}

__device__ void Point::setCoordinates(float x, float y, float z)
{
    this->_x = x;
    this->_y = y;
    this->_z = z;
}
__device__ float Point::x() const { return this->_x; }

__device__ float Point::y() const { return this->_y; }

__device__ float Point::z() const { return this->_z; }

__device__ __host__
    Point
    Point::operator-(Point const &other)
{
    float result_x = this->_x - other.x();
    float result_y = this->_y - other.y();
    float result_z = this->_z - other.z();
    return Point(result_x, result_y, result_z);
}

__device__ __host__
    Point
    Point::operator+(Point const &other)
{
    float result_x = this->_x + other.x();
    float result_y = this->_y + other.y();
    float result_z = this->_z + other.z();
    return Point(result_x, result_y, result_z);
}

__device__ __host__
    Point Point::operator*(float const &other)
{
    float result_x = this->_x * other;
    float result_y = this->_y * other;
    float result_z = this->_z * other;
    return Point(result_x, result_y, result_z);
}
