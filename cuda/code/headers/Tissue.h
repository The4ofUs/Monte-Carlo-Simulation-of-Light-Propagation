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
     * 
     * 
     *  1. Checks if the photon is out of radial boundary
     *  2. Checks if Photon is out of axial boundary
     * 
     *   ##The Math
     * 
     * (1)
     * 
     *   AxisDirection = (center1 - center0)
     * 
     *   P = Center + AxisDirection*t      //Point on the cylinder axis
     * 
     *   V1 = P1 - P     // P1 is the position of the photon
     * 
     *   V1 = P1 - Center - AxisDirection*t
     * 
     *   V1.AxisDirection = 0
     * 
     *   (P1 - Center - AxisDirection*t).AxisDirection = 0
     * 
     *   (P1x - Centerx - AxisDirectionx*t)*AxisDirectionx + 
     *   (P1y - Centery - AxisDirectiony*t)*AxisDirectiony + 
     *   (P1z - Centerz - AxisDirectionz*t)*AxisDirectionz = 0 
     *   
     *   t = C . (A - B) / ||C||^2
     * 
     *   where
     * 
     *   A : **Photon**'s position
     * 
     *   B : Center of one of the two circular faces of the cylinder
     * 
     *   C : Axis Direction
     * 
     * 
     * 
     *   (2)
     * 
     *   D = (Center1 - Center0).getAbsDistance()
     * 
     * @param point (**Point**) The current position of the **Photon**
     * @return Whether the photon escaped the tissue or not
     */
    __device__ bool escaped(Point position);
    /**
     * @brief The passed **Photon**'s weight gets decremented according to the **Tissue**'s coefficients
     * 
     * @param photon (**Photon**)
     */
    __device__ void attenuate(Photon &photon);

private:
    /**
 * @brief **Tissue**'s Radius
 * 
 */
    float _radius;
    /**
     * @brief First circular face center of the **Tissue**
     */
    Point _center0;
    /**
     * @brief Second circular face center of the **Tissue**
     */
    Point _center1;
    /**
     * @brief Where the circulare faces look at
     */
    Vector _normal;
    /**
     * @brief Scattering Coefficient
     */
    float _Ms;
    /**
     * @brief Absorption Coefficient
     */
    float _Ma;
    /**
     * @brief Total Coefficient
     * 
     * Calculated from both the Absorption and the Scattering Coefficients
     */
    float _Mt;
};

#endif