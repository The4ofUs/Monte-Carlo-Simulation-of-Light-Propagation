#include "/home/gamila/Documents/GP/Task4-RandomWalkCUDA/3D-Random-Walk-CUDA/include/Point.h"
#include <iostream>
#include <vector>


//using namespace std;


void Point::setCoordinates(float x, float y, float z)
{
    this->_x = x;
    this->_y = y;
    this->_z = z;
}

float Point::getX() const { return this->_x; }
float Point::getY() const { return this->_y; }
float Point::getZ() const { return this->_z; }

//int main() {
//Point origin;
//origin.setCoordinates(10.3f, 0.f, 0.f);


//std:: cout << origin.getX() << endl
//;}

