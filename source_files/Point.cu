#include "Point.h"
#include <iostream>
#include <vector>


 void Point::setCoordinates(float x, float y, float z)
{
    this->_x = x;
    this->_y = y;
    this->_z = z;
}
 float Point::getX() const { return this->_x; }

 float Point::getY() const { return this->_y; }

 float Point::getZ() const { return this->_z; }

