#include "../headers/Point.h"


Point::Point(float x, float y, float z)
{
    setCoordinates(x, y, z);
}


Point::Point()
{
    setCoordinates(0.f, 0.f, 0.f);
}

void Point::setCoordinates(float x, float y, float z)
{
    this->_x = x;
    this->_y = y;
    this->_z = z;
}
float Point::x() const { return this->_x; }

float Point::y() const { return this->_y; }

float Point::z() const { return this->_z; }


    Point
    Point::operator-(Point const &other)
{
    float result_x = this->_x - other.x();
    float result_y = this->_y - other.y();
    float result_z = this->_z - other.z();
    return Point(result_x, result_y, result_z);
}


    Point
    Point::operator+(Point const &other)
{
    float result_x = this->_x + other.x();
    float result_y = this->_y + other.y();
    float result_z = this->_z + other.z();
    return Point(result_x, result_y, result_z);
}


    Point Point::operator*(float const &other)
{
    float result_x = this->_x * other;
    float result_y = this->_y * other;
    float result_z = this->_z * other;
    return Point(result_x, result_y, result_z);
}
