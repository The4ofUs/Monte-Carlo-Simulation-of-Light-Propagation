#ifndef TISSUE_H
#define TISSUE_H

#include "Photon.h"

/**
 * @brief 
 * A tissue class to represent cylindrical tissue in 3D space
 */

class Tissue
{
public:
    __host__ Tissue(float radius, Point c0, Point c1, float absorpCoeff, float scatterCoeff);
    /**
     * @brief 
     * 1- Check if the photon is out of radial boundary
       2- Check if Photon is out of axial boundary

        (1) 
        AxisDirection = (center1 - center0)     // Won't matter because we are dealing with abs distances
        P = Center + AxisDirection*t      //Point on the cylinder axis
        V1 = P1 - P     // P1 is the position of the photon
        V1 = P1 - Center - AxisDirection*t
        V1.AxisDirection = 0
        (P1 - Center - AxisDirection*t).AxisDirection = 0
        (P1x - Centerx - AxisDirectionx*t)*AxisDirectionx + 
        (P1y - Centery - AxisDirectiony*t)*AxisDirectiony + 
        (P1z - Centerz - AxisDirectionz*t)*AxisDirectionz = 0 
        
        t = C . (A - B) / ||C||^2

        where
        A : Photon Position
        B : Center of one of the two circular faces of the cylinder
        C : Axis Direction



        (2)
        D = (Center1 - Center0).getAbsDistance()
     * 
     * @param point 
     * @return Whether the photon escaped the tissue or not
     */
    __device__ bool escaped(Point position);
    __device__ void attenuate(Photon &photon);

private:
    float _radius;
    Point _center0;
    Point _center1;
    Vector _normal;
    float _Ms;
    float _Ma;
    float _Mt;
};

#endif