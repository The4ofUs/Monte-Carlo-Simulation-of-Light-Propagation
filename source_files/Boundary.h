#include <cmath>
#include "Point.h"
#include "MyMathLibrary.h"
class Boundary {

    Boundary(float r, Point c){
        radius = r;
        center = c;
    }


private:

float radius;
Point center;

public:

void setRadius(float r){
    radius = r;
}

float getRadius(){
    return radius;
}

void setCenter(Point c){
    center = c;
}

Point getCenter(){
    return center;
}

bool isCrossed(Ray ray){
    float absDistance = (float) sqrt(pow(ray.getCurrentPos().getX(),2),pow(ray.getCurrentPos().getY(),2),pow(ray.getCurrentPos().getZ(),2));
    if(absDistance >= radius){
        return true;
    } else {
        return false;
    }
}

Point getIntersectionPoint(Ray ray){
    if(this.isCrossed()){
        Point rayOrigin = ray.getPrevPos();
        Point rayDirection = ray.getDirection();
        Point p = new Point();
        p.setCoordinates((center.getX() - rayOrigin.getX()),(center.getY() - rayOrigin.getY()), (center.getZ() - rayOrigin.getZ()));
        float tca = dotProduct(p,rayDirection);
        float d2 = dotProduct(p,p) - tca * tca; 
        float thc = sqrt(pow(radius,2) - d2); 
        float t0 = tca - thc; 
        float t1 = tca + thc;
        float t;
        if (t0 > t1) std::swap(t0, t1); 
 
        if (t0 < 0) { 
            t0 = t1; // if t0 is negative, let's use t1 instead 
        } 
        t = t0;        // this is the intersection distance from the ray origin to the hit point 

        Point intersectionPoint = new Point();
        intersectionPoint.setCoordinates((rayOrigin.getX()+rayDirection.getX()*t),(rayOrigin.getY()+rayDirection.getY()*t),(rayOrigin.getZ()+rayDirection.getZ()*t));
        return intersectionPoint;

    } else {
        return nullptr;
    }
}



}





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
