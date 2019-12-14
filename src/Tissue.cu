#include "Tissue.h"

__host__ Tissue::Tissue(float radius, Point c0, Point c1, float absorbCoeff, float scatterCoeff)
{
    this->_radius = radius;
    this->_center0 = c0;
    this->_center1 = c1;
    this->_axis = Vector(c0, c1).normalize();
    this->_Ma = absorbCoeff;
    this->_Ms = scatterCoeff;
    this->_Mt = absorbCoeff + scatterCoeff;
}

__device__ bool Tissue::escaped(Photon photon)
{
    Point A = photon.position();
    Point B = this->_center0;
    Vector C = this->_axis;
    float t = C.dot(A - B) / C.getAbsDistance() * C.getAbsDistance();
    Point P = B + C * t;
    float d = A.getAbsDistance(P);
    if (d > this->_radius)
    {
        return true;
    }
    float D = (this->_center1 - this->_center0).getAbsDistance();
    float E = (P - this->_center0).getAbsDistance();
    if (E > D)
    {
        return true;
    }
    E = (P - this->_center1).getAbsDistance();
    if (E > D)
    {
        return true;
    }
    return false;
}

__device__ void Tissue::attenuate(Photon photon)
{
    float newWeight = photon.weight() - this->_Ms * photon.weight() / this->_Mt;
    photon.setWeight(newWeight);
}