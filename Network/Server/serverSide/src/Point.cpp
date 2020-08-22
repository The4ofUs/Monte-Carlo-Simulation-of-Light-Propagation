#include "../headers/Point.h"

Point::Point(double x, double y, double z)
{
    setCoordinates(x, y, z);
}

Point::Point()
{
   setCoordinates(0.f, 0.f, 0.f);
}


 void Point::setCoordinates(double x, double y, double z)
{
    this->_x = x;
    this->_y = y;
    this->_z = z;
}
 double Point::x()  { return this->_x; }

 double Point::y() { return this->_y; }

 double Point::z()  { return this->_z; }





