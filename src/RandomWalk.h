#ifndef RANDOMWALK_H
#define RANDOMWALK_H

#include "Boundary.h"
#include "RNG.h"
#include "Detector.h"
#include "Photon.h"

/**
 * @brief randomWalk
 * keeps wandering around with the photon in the 3D space
 * @return The Point where the Photon hits the Boundary
 */
__device__ Photon randomWalk(curandState_t *states, int idx, Detector detector, RNG rng)
{
    Photon photon = Photon();
    while (photon.position().getAbsDistance() < detector.getAbsDistance())
    {
        photon.move(rng.getRandomDirection(states, idx), rng.getRandomStep(states, idx));
    }
    if (detector.isHit(photon))
    {
        photon.setPosition(detector.getIntersectionPoint(photon));
        return photon;
    }
    else
        return Photon();
}

#endif