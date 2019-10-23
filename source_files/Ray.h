#ifndef Ray_H
#define Ray_H
#include "RandomnessGenerator.h"

class Ray
{

public:
    void startFrom(Point startingPoint); // Sets getYour starting point
    void setDirection(Point direction);  // Sets the direction of the ragetY
    void setStep(float step);           // Sets the step of movement
    Point getCurrentPos() const;
    Point getDirection() const;
    float getStep() const;
    void move(); // The point moves in the specified direction with the given step -The function relies on member attributes that getYou should set first-

private:
    Point _currentPos;
    Point _direction;
    float _step;
};
#endif