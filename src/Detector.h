#include "Point.h"
#include "Vector.h"

/**
 *  TODO: 
 *      Getting the disc equation in 3D space
 *          1- Start by getting a vector on the plane itself V.
 *              i- We already have a point on the plane which is the center C=(Cx,Cy,Cz).
 *             ii- Now let's suppose we have another point P=(Px,Py,Pz) on the plane.
 *            iii- V = P - C = (Px-Cx, Py-Cy, Pz-Cz).
 *          2- We know that the dot product of a vector and its normal is zero.
 *              i- N = normal to the plane = (Nx, Ny, Nz).
 *             ii- N.V = 0.
 *            iii- Nx(Px-Cx) + Ny(Py-Cy) + Nz(Pz-Cz) = 0
 *          3- We will assume the user will define the N and the C so eventually we yield:
 *              Nx*X + Ny*Y + Nz*Z - (Nx*Cx + Ny*Cy + Nz*Cz) = 0    Plane Equation
 *          4- For a circular plane we need to 
 * 
 * 
 * 
 *      
 * 
 * 
 * 
 * 
 * 
 */

class Detector
{

public:
    __device__ __host__ Detector(float radius, Point center, Vector normal);

private:
    float _radius;
    Point _center;
    Vector _normal;
};