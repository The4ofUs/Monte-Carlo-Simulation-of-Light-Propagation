#ifndef RANDOMWALK_H
#define RANDOMWALK_H

#include "Boundary.h"
#include "RNG.h"
#include "Detector.h"

/**
 * @brief randomWalk
 * keeps wandering around with the photon in the 3D space
 * @return The Point where the Photon hits the Boundary
 */
__device__ Point randomWalk(curandState_t *states, int idx, Detector detector, RNG rng)
{
    Ray ray = Ray(Point(), Point());
    while (ray.getCurrent().getAbsDistance() < detector.getAbsDistance())
    {
        ray.move(rng.getRandomDirection(states, idx), rng.getRandomStep(states, idx));
    }
    if (detector.isHit(ray))
    {
        return detector.getIntersectionPoint(ray);
    }
    else
        return Point(0.f, 0.f, 0.f);
}

#endif