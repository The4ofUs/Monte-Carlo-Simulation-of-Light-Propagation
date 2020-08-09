#ifndef RANDOMWALK_H
#define RANDOMWALK_H

#include "RNG.h"
#include "Detector.h"
#include "Tissue.h"
#define WEIGHT_THRESHOLD 0.0001f
#define ROULETTE_CHANCE 0.1f

Photon randomWalk(Detector detector, RNG rng, Tissue tissue)
{
    Photon photon = Photon(detector.getCenter());
    bool first_step = true;
    Ray path;

    while (photon.getState() == photon.ROAMING)
    {
        if (first_step)
        {
            path = Ray(photon.getPosition(), detector.getNormal(), rng.getRandomStep());
            first_step = false;
        }
        else
        {
            path = Ray(photon.getPosition(), rng.getRandomDirection(), rng.getRandomStep());
        }

        photon.moveAlong(path);
        tissue.attenuate(photon);
        if (detector.isHit(photon, path))
        {
            photon.setState(photon.DETECTED);
            break;
        }

        if (!tissue.escaped(photon.getPosition()))
        {
            if (photon.getWeight() < WEIGHT_THRESHOLD)
            {
                rng.roulette(photon, ROULETTE_CHANCE);
            }
        }
        else
        {
            photon.setState(photon.ESCAPED);
            break;
        }
    }

    return photon;
}

#endif