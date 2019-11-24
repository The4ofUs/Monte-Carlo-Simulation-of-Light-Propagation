#include "Point.h"

__device__
 void Point::setCoordinates(float x, float y, float z)
{
    this->_x = x;
    this->_y = y;
    this->_z = z;
}
__device__ float Point::getX() const { return this->_x; }

__device__  float Point::getY() const { return this->_y; }

__device__  float Point::getZ() const { return this->_z; }

    __device__ __host__
    Point Point::operator - (Point const &other) { 
        float result_x = this->_x - other.getX();
        float result_y = this->_y - other.getY();
        float result_z = this->_z - other.getZ();
        return Point(result_x, result_y, result_z); 
    }

    __device__ __host__
    Point Point::operator + (Point const &other) { 
        float result_x = this->_x + other.getX();
        float result_y = this->_y + other.getY();
        float result_z = this->_z + other.getZ();
        return Point(result_x, result_y, result_z); 
    }

