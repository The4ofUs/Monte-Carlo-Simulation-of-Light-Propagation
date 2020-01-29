#include "../headers/Vector.h"

Vector::Vector()
{
    this->setCoordinates(0.f, 0.f, 0.f);
}

Vector::Vector(Point point)
{
    this->_x = point.x();
    this->_y = point.y();
    this->_z = point.z();
}

Vector::Vector(float x, float y, float z)
{
    this->_x = x;
    this->_y = y;
    this->_z = z;
}

Vector::Vector(Point point1, Point point2)
{
    this->_x = point2.x() - point1.x();
    this->_y = point2.y() - point1.y();
    this->_z = point2.z() - point1.z();
}
