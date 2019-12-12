#include "Vector.h"
#include "Vector.cu"
#include "Point.h"
#include "Point.cu"


int main(){
    Vector A = Vector(Point(1.0,5.0,3.0),Point(5.0,1.0,3.0));
    Vector B = Vector(2.0,4.0,6.0);
    Vector crossProduct = A.cross(B);
    Vector normalizedCrossProduct = crossProduct.normalize();
    float dotProduct = A.dot(B);
    printf("A = (%f,%f,%f) \nB = (%f,%f,%f) \n", A.x(),A.y(),A.z(),B.x(),B.y(),B.z());
    printf("A.B = %f \n", dotProduct);
    printf("AxB = (%f,%f,%f) \n", crossProduct.x(), crossProduct.y(), crossProduct.z());
    printf("Normalized AxB = (%f,%f,%f) \n", normalizedCrossProduct.x(), normalizedCrossProduct.y(), normalizedCrossProduct.z());
    return 0;
}