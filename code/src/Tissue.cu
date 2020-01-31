#include "../headers/Tissue.h"

__host__ Tissue::Tissue(float radius, Point c0, Point c1, float absorbCoeff, float scatterCoeff)
{
    this->_radius = radius;
    this->_center0 = c0;
    this->_center1 = c1;
    this->_normal = Mathematics::calculateNormalizedVector(Vector(c0, c1));
    this->_Ma = absorbCoeff;
    this->_Ms = scatterCoeff;
    this->_Mt = absorbCoeff + scatterCoeff;
}

__device__ bool Tissue::escaped(Point position)
{
    Point A = position;
    Point B = this->_center0;
    Vector C = this->_normal;
    float t = Mathematics::calculateDotProduct(C, (A - B)) / Mathematics::calculateAbsDistance(C) * Mathematics::calculateAbsDistance(C);
    Point P = B + C * t;
    float d = Mathematics::calculateAbsDistance(A, P);
    if (d > this->_radius)
    {
        return true;
    }
    float D = Mathematics::calculateAbsDistance(this->_center1 - this->_center0);
    float E = Mathematics::calculateAbsDistance(P - this->_center0);
    if (E > D)
    {
        return true;
    }
    E = Mathematics::calculateAbsDistance((P - this->_center1));
    if (E > D)
    {
        return true;
    }
    return false;
}

__device__ void Tissue::attenuate(Photon &photon)
{
    float newWeight = this->_Ms * photon.getWeight() / this->_Mt;
    photon.setWeight(newWeight);
}