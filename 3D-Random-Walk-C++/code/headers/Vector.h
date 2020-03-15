#ifndef VECTOR_H
#define VECTOR_H

#include "~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/headers/Point.h"
/**
 * @brief Inherits from Point
 */
class Vector : public Point
{
public:
    /**
 * @brief Constructs a (0,0,0) **Vector**
 */
   Vector();
    /**
 * @brief Constructs a **Vector** of direction (*x*,*y*,*z*) relative to (0,0,0)
 * 
 * @param x (float) X coordinate
 * @param y (float) Y coordinate
 * @param z (float) Z coordinate
 */
   Vector(float x, float y, float z);
    /**
 * @brief Constructs a **Vector** of direction *point* relative to (0,0,0)
 * 
 * @param point (**Point**)
 */
   Vector(Point point);

    /**
 * @brief Constructs a relative **Vector**
 * 
 * @param point1 (**Point**)
 * @param point2 (**Point**)
 */
   Vector(Point point1, Point point2);
};
#endif