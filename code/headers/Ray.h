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
     * @param origin
     * Starting origin of the ray
     * @param direction
     * Direction of the ray
     */
    __device__ __host__ Ray(Point origin, Vector direction, float step);
    __device__ __host__ Ray();

    /**
     * @brief setStep
     * Sets the step along the ray.
     * @param step
     * Step value.
     */
    __device__ __host__ void setStep(float step);

    __device__ __host__ void setDirection(Vector v);

    __device__ __host__ void setOrigin(Point p);

    __device__ __host__ Point getTip() const;

    /**
     * @brief getDirection
     * @return
     * The current direction of the ray.
     */
    __device__ __host__ Vector getDirection() const;

    /**
     * @brief getPrevPos
     * @return
     * The previous position of the ray.
     */
    __device__ __host__ Point getOrigin() const;

    /**
     * @brief getStep
     * @return
     * The current step along the ray.
     */
    __device__ __host__ float getStep() const;

protected:
    /**
     * @brief _prevPos
     * The previous position of the ray.
     */
    Point _origin;

    /**
     * @brief _tip
     * Represents the position of the Ray's tip
     * 
     */
    Point _tip;
    /**
     * @brief _step
     * The magnitude of movement in the specific _direction.
     */
    float _step;
    /**
     * @brief _direction
     * The current direction unit vector of the ray.
     */
    Vector _direction;
};
#endif