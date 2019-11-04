#ifndef RAY_H
#define RAY_H

#include "RNG.h"

/**
 * @brief The Ray class
 */
class Ray
{
public:

    /**
     * @brief startFrom
     * Sets the ray starting point.
     * @param startingPoint
     * The starting point of the ray.
     */
    __device__
    void startFrom(Point startingPoint);

    /**
     * @brief setDirection
     * Sets the direction of the ray
     * @param direction
     * The direction of the ray.
     */
    __device__
    void setDirection(Point direction);

    /**
     * @brief setStep
     * Sets the step along the ray.
     * @param step
     * Step value.
     */
    __device__
    void setStep(float step);

    /**
     * @brief getCurrentPos
     * @return
     * The current position of the ray.
     */
    __device__
    Point getCurrentPos() const;

    /**
     * @brief getDirection
     * @return
     * The current direction of the ray.
     */
    __device__
    Point getDirection() const;

    /**
     * @brief getStep
     * @return
     * The current step along the ray.
     */
    __device__
    float getStep() const;

    /**
     * @brief move
     * The point moves in the specified direction with the given step.
     * The function relies on member attributes that getYou should set first.
     */
    __device__
    void move();

private:

    /**
     * @brief _currentPos
     * The current position of the ray.
     */
    Point _currentPos;

    /**
     * @brief _direction
     * The current direction unit vector of the ray.
     */
    Point _direction;

    /**
     * @brief _step
     * The step along the ray.
     */
    float _step;
};

#endif // RAY_H
