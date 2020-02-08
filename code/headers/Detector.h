#ifndef DETECTOR_H
#define DETECTOR_H

#include "Photon.h"

/**
 * 
 * Photons that hit the **Detector** screen are marked with Photon::DETECTED state and are terminated at that **Point**
 * 
 */

class Detector
{

public:
    /**
 * @brief Constructor
 * 
 * @param radius (float)
 * @param center (**Point**)
 * @param normal (**Vector**)
 * 
 */
    __host__ Detector(float radius, Point center, Vector normal);
    /**
     * @return The center of the **Detector**'s screen as a **Point**
     */
    __device__ Point getCenter();
    /**
     * @return The normal of the **Detector**'s screen as a normalized **Vector**
     */
    __device__ Vector getNormal();
    /**
     * @brief Checks whether the **Photon** has actually hit the **Detector**'s screen or not
     * 
     * The function takes the last path the **Photon** took and checks whether the path intersects with
     * the screen, if it does, the function simply projects the **Photon** back onto the Detector's screen and
     * terminates the **Photon**
     * 
     * @param photon (**Photon**)
     * @param path (**Ray**)
     * @return Whether the **Photon** did hit the **Detector**'s screen or not
     */
    __device__ bool isHit(Photon &photon, Ray path);

    /**
     * @brief Calculates the intersection **Point** between the **Photon**'s path and the **Detector**'s screen
     * 
     * @param path (**Ray**)
     * @return The exact **Point** of intersection
     */
    __device__ Point calculateIntersectionPoint(Ray path);

private:
    /**
 * @brief Radius of the **Detector**'s screen
 * 
 */
    float _radius;
    /**
     * @brief The center of the **Detector**'s screen in 3D space
     * 
     */
    Point _center;
    /**
     * @brief Direction where the **Detector**'s screen faces
     * 
     */
    Vector _normal;
};
#endif