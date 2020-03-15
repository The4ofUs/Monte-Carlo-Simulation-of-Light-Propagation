#ifndef RAY_H
#define RAY_H
#include "~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/headers/Vector.h"
#include "~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/headers/mathematics.h"
/**
 * @brief The Ray class
 */
class Ray
{
public:
    /**
     * @brief Constructor 
     * @param origin (**Point**)
     * Starting origin of the ray
     * @param direction (**Vector**)
     * Direction of the ray
     * @param step (float)
     * Step value.
     */
    Ray(Point origin, Vector direction, float step);
    Ray();

    /**
     * @param step (float)
     */
    void setStep(float step);

    /**
 * @param v (**Vector**) 
 * setDirection() insures that the vector passed is normalized
 */
    void setDirection(Vector v);
    /**
 * @param p (**Point**)
 * 
 */
    void setOrigin(Point p);
    /**
 * @return The position of the tip of the ray as a **Point**
 * 
 */
    Point getTip() const;

    /**
     * @return
     * The current direction of the ray as a normalized **Vector**
     */
    Vector getDirection() const;

    /**
     * @return
     * The origin **Point** of the ray.
     */
    Point getOrigin() const;

    /**
     * @return
     * The current step along the ray.
     */
    float getStep() const;

protected:
    /**
     * The origin of the ray.
     */
    Point _origin;

    /**
     * Represents the position of the Ray's tip
     */
    Point _tip;
    /**
     * The magnitude of movement in the specific _direction.
     */
    float _step;
    /**
     * The current direction unit vector of the ray.
     */
    Vector _direction;
};
#endif