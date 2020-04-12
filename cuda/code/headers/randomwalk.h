#ifndef RANDOMWALK_H
#define RANDOMWALK_H

#include "RNG.h"
#include "Detector.h"
#include "MultiLayer.h"
#define WEIGHT_THRESHOLD 0.0001f
#define ROULETTE_CHANCE 0.1f

/**
 * @brief randomWalk
 * keeps wandering around with the photon in the 3D space
 * @return The final state of the photon
 */
__device__ Photon randomWalk(curandState_t *states, int idx, Detector detector, RNG rng, MultiLayer layer1, MultiLayer layer2, MultiLayer layer3)
{
    Photon photon = Photon(detector.getCenter());
    bool first_step = true;
    bool first_layer = true; // True until going through the second layer for the first time
    Ray path;

    while (photon.getState() == photon.ROAMING)
    {

        if (first_step)
        {
            path = Ray(photon.getPosition(), detector.getNormal(), rng.getRandomStep(states, idx));
            first_step = false;
        }
        else
        {
            path = Ray(photon.getPosition(), rng.getRandomDirection(states, idx), rng.getRandomStep(states, idx));
        }

        photon.moveAlong(path);

        // attenuation
        if (first_layer)
        {
            layer1.attenuate(photon);
        }

        else if (layer1.crossedBoundaryDown(photon.getPosition()))
        {
            first_layer = false;
            layer2.attenuate(photon);
        }
        else if (layer2.crossedBoundaryUp(photon.getPosition()))
        {
            layer1.attenuate(photon);
        }
        else if (layer2.crossedBoundaryDown(photon.getPosition()))
        {
            layer3.attenuate(photon);
        }
        else if (layer3.crossedBoundaryUp(photon.getPosition()))
        {
            layer2.attenuate(photon);
        }

        if (detector.isHit(photon, path))
        {
            photon.setState(photon.DETECTED);
            break;
        }

        if (!(layer1.crossedBoundaryUp(photon.getPosition())) || !(layer3.crossedBoundaryDown(photon.getPosition())))
        {
            if (photon.getWeight() < WEIGHT_THRESHOLD)
            {
                rng.roulette(photon, ROULETTE_CHANCE, states, idx);
            }
        }
        else
        {
            if (layer1.crossedBoundaryUp(photon.getPosition()) ||layer3.crossedBoundaryDown(photon.getPosition()) )
            {
                first_layer = false;
                photon.setState(photon.ESCAPED);
                break;
            }
        }
    }

    return photon;
}

#endif