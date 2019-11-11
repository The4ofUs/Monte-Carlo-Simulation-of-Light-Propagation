#include "Boundary.h"
using namespace std;

__device__
float Boundary::dotProduct(Point point1, Point point2){return point1.getX()*point2.getX() + point1.getY()*point2.getY() + point1.getZ()*point2.getZ();}

__device__
void Boundary::swap(float &num1, float &num2){
    float temp = num1;
    num1 = num2;
    num2 = temp;
}

__device__ Boundary::Boundary(float r, Point c){
    _radius = r;
    _center = c;
}

__device__ void Boundary::setRadius(float r){_radius = r;}

__device__ float Boundary::getRadius() const {return _radius;}

__device__ void Boundary::setCenter(Point c){_center = c;}

__device__ Point Boundary::getCenter() const {return _center;}

__device__ bool Boundary::isCrossed(Ray ray){
    float absDistance = (float) sqrtf((float) powf(ray.getCurrentPos().getX(),2) + (float) powf(ray.getCurrentPos().getY(),2) + (float) powf(ray.getCurrentPos().getZ(),2));
    if(absDistance >= _radius){
        return true;
    } else {
        return false;
    }
}


__device__ Point Boundary::getIntersectionPoint(Ray ray){
    if(this->isCrossed(ray)){
        Point rayOrigin = ray.getPrevPos();
        Point rayDirection = ray.getDirection();
        Point p = Point((_center.getX() - rayOrigin.getX()),(_center.getY() - rayOrigin.getY()), (_center.getZ() - rayOrigin.getZ()));
        float tca = dotProduct(p,rayDirection);
        float d2 = dotProduct(p,p) - tca * tca; 
        float thc = (float) sqrtf((float) powf(_radius,2.0) - d2); 
        float t0 = tca - thc; 
        float t1 = tca + thc;
        float t;
        if (t0 > t1) swap(t0, t1);
 
        if (t0 < 0) { 
            t0 = t1; // if t0 is negative, let's use t1 instead 
        } 
        t = t0;        // this is the intersection distance from the ray origin to the hit point 

        return Point((rayOrigin.getX()+rayDirection.getX()*t),(rayOrigin.getY()+rayDirection.getY()*t),(rayOrigin.getZ()+rayDirection.getZ()*t));

    } else {
        return Point(0.f,0.f,0.f);
    }
}


