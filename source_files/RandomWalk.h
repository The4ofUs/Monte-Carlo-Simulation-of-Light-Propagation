#ifndef RANDOMWALK_H
#define RANDOMWALK_H

#include "header.h"
#include "Boundary.h"

// Returns the final position after a series of random wandering around in the 3D-space
__device__ Point randomWalk(curandState_t *states)
{
    // Creating an instance of our RandomnessGenerator class
    RandomnessGenerator randomnessGenerator;
    Point origin = new Point();
    Ray ray= new Ray(origin);
    Boundary boundary = new Boundary(5.0, origin);
    
    // This for loop simulates each step the photon takes
    while (!boundary.isCrossed(ray))
    {
        // Setting ray direction
        // Passing "states" and "i" as arguments for the sake of changing the seed and the state of the generator
        // for each iteration
        ray.setDirection(randomnessGenerator.getRandomPoint(states, i));

        // Setting ray step
        // Passing "states" and "i" as arguments for the sake of changing the seed and the state of the generator
        // for each iteration
        ray.setStep(randomnessGenerator.getRandomStep(states, i));

        // Move!
        ray.move();
    }

    return boundary.getIntersectionPoint(ray);
}

#endif