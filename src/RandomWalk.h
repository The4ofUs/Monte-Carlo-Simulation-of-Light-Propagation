#ifndef RANDOMWALK_H
#define RANDOMWALK_H

#include "Boundary.h"
#include "RNG.h"
#include "Detector.h"
#include "Photon.h"
#include "Tissue.h"
#define WEIGHT_THRESHOLD 0.0001f

/**
 * @brief randomWalk
 * keeps wandering around with the photon in the 3D space
 * @return The final state of the photon
 */
__device__ Photon randomWalk(curandState_t *states, int idx, Detector detector, RNG rng, Tissue tissue)
{
    Photon photon = Photon();
    while (photon.state() == photon.ROAMING_IN_AIR || photon.state() == photon.ROAMING_IN_TISSUE)
    {
        photon.move(rng.getRandomDirection(states, idx), rng.getRandomStep(states, idx));
        if (detector.isHit(photon))
        {
            photon.setState(photon.DETECTED);
            break;
        }

        if (photon.weight() < WEIGHT_THRESHOLD)
        {
            photon.roulette(rng, states, idx);
            if (photon.state() == photon.TERMINATED)
            {
                break;
            }
        }

        if (!tissue.escaped(photon))
        {
            photon.setState(photon.ROAMING_IN_TISSUE);
            tissue.attenuate(photon);
        }
        else
        {
            photon.setState(photon.ROAMING_IN_AIR);
            photon.loseWeight();
        }
    }

    return photon;
}

#endif