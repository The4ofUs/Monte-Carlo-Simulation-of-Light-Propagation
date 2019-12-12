#ifndef Ray_H
#define Ray_H
#include "Vector.h"

/**
 * @brief The Ray class
 */
class Ray
{
public:
    /**
     * @brief Constructor 
     * @param startingPoint
     * Starting origin of the ray
     * @param direction
     * Direction of the ray
     */
    __device__ Ray(Point startingPoint, Vector direction);
    __device__ Ray();

    /**
     * @brief setDirection
     * Sets the direction of the ray
     * @param direction
     * The direction of the ray.
     */
    __device__ void setDirection(Vector direction);

    /**
     * @brief setStep
     * Sets the step along the ray.
     * @param step
     * Step value.
     */
    __device__ void setStep(float step);

    /**
     * @brief getCurrentPos
     * @return
     * The current position of the ray.
     */
    __device__ Point getTip() const;

    /**
     * @brief getDirection
     * @return
     * The current direction of the ray.
     */
    __device__ Vector getDirection() const;

    /**
     * @brief getPrevPos
     * @return
     * The previous position of the ray.
     */
    __device__ Point getOrigin() const;

    /**
     * @brief getStep
     * @return
     * The current step along the ray.
     */
    __device__ float getStep() const;

    /**
     * @brief updateRayState
     * @return
     * Keeps the parameters responsible for the movements stored in the Ray object
     */
    __device__ void updateRayState(Vector direction);

    /**
     * @brief move
     * The point moves in the specified direction with the given step.
     */
    __device__ void move(Vector direction, float step);

protected:
    /**
     * @brief _prevPos
     * The previous position of the ray.
     */
    Point _origin;
    /**
     * @brief _tipPos
     * The current position of the ray.
     */
    Point _tip;
    /**
     * @brief _direction
     * The current direction unit vector of the ray.
     */
    Vector _direction;
};
#endif