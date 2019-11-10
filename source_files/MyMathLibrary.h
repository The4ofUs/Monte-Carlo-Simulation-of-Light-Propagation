
#include <cmath>

float dotProduct(Point point1, Point point2)
{
    float result = point1.getX()*point2.getX() + point1.getY()*point2.getY() + point1.getZ()*point2.getZ();
    return result;
}

bool solveQuadratic(const float &a, const float &b, const float &c, float &x0, float &x1) 
{ 
    float discr = b * b - 4 * a * c; 
    if (discr < 0) return false; 
    else if (discr == 0) { 
        x0 = x1 = - 0.5 * b / a; 
    } 
    else { 
        float q = (b > 0) ? 
            -0.5 * (b + sqrt(discr)) : 
            -0.5 * (b - sqrt(discr)); 
        x0 = q / a; 
        x1 = c / q; 
    } 
 
    return true; 
} 