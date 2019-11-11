#include <cmath>
#include "Point.h"

class Boundary {

private:

float radius;
Point center;
Point intersectionPoint;

__device__
float dotProduct(Point point1, Point point2)
{
    float result = point1.getX()*point2.getX() + point1.getY()*point2.getY() + point1.getZ()*point2.getZ();
    return result;
}

__device__
void swap(float &num1, float &num2){
    float temp = num1;
    num1 = num2;
    num2 = temp;
}

public:

 __device__ Boundary(float r, Point c){
            radius = r;
            center = c;
        }

__device__ void setRadius(float r){
    radius = r;
}

__device__ float getRadius(){
    return radius;
}

__device__ void setCenter(Point c){
    center = c;
}

__device__ Point getCenter(){
    return center;
}

__device__ bool isCrossed(Ray ray){
    float absDistance = (float) sqrtf((float) powf(ray.getCurrentPos().getX(),2) + (float) powf(ray.getCurrentPos().getY(),2) + (float) powf(ray.getCurrentPos().getZ(),2));
    if(absDistance >= radius){
        return true;
    } else {
        return false;
    }
}

__device__ Point getIntersectionPoint(Ray ray){
    if(isCrossed(ray)){
        Point rayOrigin = ray.getPrevPos();
        Point rayDirection = ray.getDirection();
        Point p;
        p.setCoordinates((center.getX() - rayOrigin.getX()),(center.getY() - rayOrigin.getY()), (center.getZ() - rayOrigin.getZ()));
        float tca = dotProduct(p,rayDirection);
        float d2 = dotProduct(p,p) - tca * tca; 
        float thc = sqrt(pow(radius,2) - d2); 
        float t0 = tca - thc; 
        float t1 = tca + thc;
        float t;
        if (t0 > t1) swap(t0, t1);
 
        if (t0 < 0) { 
            t0 = t1; // if t0 is negative, let's use t1 instead 
        } 
        t = t0;        // this is the intersection distance from the ray origin to the hit point 

        intersectionPoint.setCoordinates((rayOrigin.getX()+rayDirection.getX()*t),(rayOrigin.getY()+rayDirection.getY()*t),(rayOrigin.getZ()+rayDirection.getZ()*t));

    }
    return intersectionPoint;
}



};





/**
 *  R0 = Ray's origin (Prev Position)
 *  Rd = The direction of the ray (Ray's Direction)
 *  t = this is the intersection distance from the ray origin to the hit point 
 *  t = dot((CenterOfTheSphere - R0), Rd)
 *  x = sqrt(r^2 - y^2)
 *  y = length(S - P)
 *  where S is the center of the sphere, P is anypoint on the Ray
 *  t1 = t+x
 *  t2 = t-x
 *  pointOfIntersection = RayOrigin + direction*t
 */
