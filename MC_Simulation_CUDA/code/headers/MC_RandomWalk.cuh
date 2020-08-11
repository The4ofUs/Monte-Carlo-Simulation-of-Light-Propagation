//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_RANDOMWALK_CUH
#define MC_SIMULATION_MC_RANDOMWALK_CUH

#include <curand_kernel.h>
#include <cstdio>
#include "MC_Photon.cuh"
#include "MC_FiberGenerator.cuh"
#include "MC_Tissue.cuh"
#include "MC_RNG.cuh"
#include "MC_MLTissue.cuh"


#define ROULETTE_CHANCE 0.1f
/*
 * Can be radically enhanced by optimizing the number of checks done per asset
 */

__device__ MC_Photon
RandomWalk(curandState_t *states, int idx, MC_FiberGenerator mcFiberGenerator, MC_MLTissue tissue) {
    /*
     * Initializing first step
     */
    MC_Point position = mcFiberGenerator.center();
    MC_Vector direction = mcFiberGenerator.lookAt();
    float step = MC_RNG::getRandomStep(states, idx, tissue.coefficient(position));
    MC_Photon photon = MC_Photon(position);
    MC_Path path = MC_Path(position, direction, step);
    /*
     * Main Loop
     */
    while (photon.isRoaming()) {
        if (tissue.isCrossing(path)) {      // Is crossing an inner boundary ?
            tissue.updatePath(path);    // Path tip should be directly on the boundary
        }
        if (mcFiberGenerator.isHit(path)) {             // Is hitting the screen ?
            photon.setState(MC_Photon::DETECTED);    // Update State
        }
        if (tissue.escaped(path) && photon.isRoaming()) {   // Escaped ?
            photon.setState(MC_Photon::ESCAPED);      // Update State
        }
        photon.moveAlong(path);         // Move along the given path
        tissue.attenuate(photon);   // Attenuate Photon accordingly
        if (photon.isDying() && photon.isRoaming()) {                       // weight < Threshold ?
            MC_RNG::roulette(photon, ROULETTE_CHANCE, states, idx);     // Roulette
        }
        if (photon.isRoaming() && tissue.onBoundary(path)) {
            if (tissue.isReflected(path, MC_RNG::getRandomNumber(states, idx))) {
                tissue.reflect(path, MC_RNG::getRandomStep(states, idx, tissue.coefficient(path.origin())));
            } else {
                tissue.refract(path, MC_RNG::getRandomStep(states, idx, tissue.coefficient(path.origin())));
            }
        } else if (photon.isRoaming()) {
            // Generate a new random path
            path = MC_RNG::getRandomPath(states, idx, photon.position(), tissue.coefficient(photon.position()));
        }
    }
    return photon;
}

#endif //MC_SIMULATION_MC_RANDOMWALK_CUH
