//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_RANDOMWALK_CUH
#define MC_SIMULATION_MC_RANDOMWALK_CUH

#include <curand_kernel.h>
#include <cstdio>
#include "MC_Photon.cuh"
#include "MC_Detector.cuh"
#include "MC_Tissue.cuh"
#include "MC_RNG.cuh"
#include "MC_MLTissue.cuh"

#define WEIGHT_THRESHOLD 0.0001f
#define ROULETTE_CHANCE 0.1f

__device__ MC_Photon RandomWalk(curandState_t *states, int idx, MC_Detector detector, MC_RNG rng, MC_MLTissue tissue) {
    /*
     * Setup for initial step
     */
    MC_Photon photon = MC_Photon(detector.center());                                                // Start at the detector's center
    float step = -1 * log(rng.getRandomStep(states, idx))/tissue.coefficient(photon.position());    // Get a random magnitude for the step
    MC_Path path = MC_Path(photon.position(), detector.lookAt(), step);                               // Initial Path
    /*
     * Main loop
     */
    while (photon.state() == MC_Photon::ROAMING) {
        if(tissue.isCrossing(path)) {
            /*
             * if crossing, then update the path to have its tip on the boundary
             */
            path.setTip(tissue.crossingPoint(path));
            /*
             * TODO : Check for reflection or transmission
             */
        }
        photon.moveAlong(path);
        tissue.attenuate(photon);
        if (detector.isHit(photon, path)) {
            photon.setState(MC_Photon::DETECTED);
            break;
        }
        if (!tissue.escaped(photon.position())) {
            if (photon.weight() < WEIGHT_THRESHOLD) {
                rng.roulette(photon, ROULETTE_CHANCE, states, idx);
            }
        } else {
            photon.setState(MC_Photon::ESCAPED);
            break;
        }
        step = -1*log(rng.getRandomStep(states, idx))/tissue.coefficient(photon.position());
        path = MC_Path(photon.position(), rng.getRandomDirection(states, idx), step);
    }
    return photon;
}

#endif //MC_SIMULATION_MC_RANDOMWALK_CUH
