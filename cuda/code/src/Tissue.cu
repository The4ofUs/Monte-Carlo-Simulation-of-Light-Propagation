#include "../headers/Tissue.h"


__host__ MultiLayer::MultiLayer(float radius, Point c0, Point c1, float absorpCoeff, float scatterCoeff)
{
    this->_radius = radius;
    this->_center0 = c0;
    this->_center1 = c1;
    this->_normal = Mathematics::calculateNormalizedVector(Vector(c0, c1));
    this->_Ma = absorpCoeff;
    this->_Ms = scatterCoeff;
    this->_Mt = absorpCoeff + scatterCoeff;
}
/*
__device__ int MultiLayer::crossedBoundary(Point position)
{
    Point A = position;
    Point B = this->_center0;
    Vector C = this->_normal;
    float t = Mathematics::calculateDotProduct(C, (A - B)) / Mathematics::calculateAbsDistance(C) * Mathematics::calculateAbsDistance(C);
    Point P = B + C * t;
    
    float D = Mathematics::calculateAbsDistance(this->_center1 - this->_center0);
    float E = Mathematics::calculateAbsDistance(P - this->_center0);
    if (E > D)
    {
        return 1; // underneath layer
    }
    E = Mathematics::calculateAbsDistance((P - this->_center1));
    if (E > D)
    {
        return 2; // upper
    }
    return 0;
}
*/
__device__ bool MultiLayer::crossedBoundaryUp(Point position)
{
    Point A = position;
    Point B = this->_center0;
    Vector C = this->_normal;
    float t = Mathematics::calculateDotProduct(C, (A - B)) / Mathematics::calculateAbsDistance(C) * Mathematics::calculateAbsDistance(C);
    Point P = B + C * t;
    
    float D = Mathematics::calculateAbsDistance(this->_center1 - this->_center0);
    float E = Mathematics::calculateAbsDistance((P - this->_center1));
    if (E > D)
    {
        return true; // upper
    }
    
    return false;   
}

__device__ bool MultiLayer::crossedBoundaryDown(Point position)
{
    Point A = position;
    Point B = this->_center0;
    Vector C = this->_normal;
    float t = Mathematics::calculateDotProduct(C, (A - B)) / Mathematics::calculateAbsDistance(C) * Mathematics::calculateAbsDistance(C);
    Point P = B + C * t;
    
    float D = Mathematics::calculateAbsDistance(this->_center1 - this->_center0);
    float E = Mathematics::calculateAbsDistance(P - this->_center0);
    if (E > D)
    {
        return true; // underneath layer
    }
    
    return false;
    
}

__device__ void MultiLayer::attenuate(Photon &photon)
{
    float newWeight = this->_Ms * photon.getWeight() / this->_Mt;
    photon.setWeight(newWeight);
}