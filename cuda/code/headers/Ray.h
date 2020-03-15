#ifndef RAY_H
#define RAY_H
#include "Vector.h"
#include "mathematics.h"

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
    __device__ __host__ Ray(Point origin, Vector direction, float step);
    __device__ __host__ Ray();

    /**
     * @param step (float)
     */
    __device__ __host__ void setStep(float step);

    /**
 * @param v (**Vector**) 
 * setDirection() insures that the vector passed is normalized
 */
    __device__ __host__ void setDirection(Vector v);
    /**
 * @param p (**Point**)
 * 
 */
    __device__ __host__ void setOrigin(Point p);
    /**
 * @return The position of the tip of the ray as a **Point**
 * 
 */
    __device__ __host__ Point getTip() const;

    /**
     * @return
     * The current direction of the ray as a normalized **Vector**
     */
    __device__ __host__ Vector getDirection() const;

    /**
     * @return
     * The origin **Point** of the ray.
     */
    __device__ __host__ Point getOrigin() const;

    /**
     * @return
     * The current step along the ray.
     */
    __device__ __host__ float getStep() const;

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