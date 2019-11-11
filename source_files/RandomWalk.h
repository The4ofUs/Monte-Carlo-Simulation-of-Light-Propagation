#ifndef RANDOMWALK_H
#define RANDOMWALK_H

#include "header.h"
#include "Boundary.h"
#include "Point.h"
#define BOUNDARY_RADIUS 5.0

// Returns the final position after a series of random wandering around in the 3D-space
__device__ Point randomWalk(curandState_t *states)
{
    // Creating an instance of our RandomnessGenerator class
    RandomnessGenerator randomnessGenerator;
    Point origin = Point(0.f, 0.f, 0.f);
    Ray ray = Ray(origin);
    Boundary boundary = Boundary(BOUNDARY_RADIUS, origin);
    long iterator = 0;
    
    // This for loop simulates each step the photon takes
    while (!boundary.isCrossed(ray))
    {
        // Setting ray direction
        // Passing "states" and "i" as arguments for the sake of changing the seed and the state of the generator
        // for each iteration
        ray.setDirection(randomnessGenerator.getRandomPoint(states, iterator));

        // Setting ray step
        // Passing "states" and "i" as arguments for the sake of changing the seed and the state of the generator
        // for each iteration
        ray.setStep(randomnessGenerator.getRandomStep(states, iterator));

        // Move!
        ray.move();

        iterator++;
    }

    return boundary.getIntersectionPoint(ray);
}

#endif