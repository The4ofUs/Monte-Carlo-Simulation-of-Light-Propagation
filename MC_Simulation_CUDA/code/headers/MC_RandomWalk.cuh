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

__device__ MC_Photon RandomWalk(curandState_t *states, int idx, MC_FiberGenerator mcFiberGenerator, MC_MLTissue tissue) {
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
        if (mcFiberGenerator.isHit(path)) {     // Is hitting the screen ?
            photon.setState(MC_Photon::DETECTED);
        }
        if (tissue.escaped(path) && photon.isRoaming()) {
            photon.setState(MC_Photon::ESCAPED);
        }
        photon.moveAlong(path);
        tissue.attenuate(photon);
        if (photon.isDying() && photon.isRoaming()) {
            MC_RNG::roulette(photon, ROULETTE_CHANCE, states, idx);
        }
        path = MC_Path(photon.position(), MC_RNG::getRandomDirection(states, idx), MC_RNG::getRandomStep(states, idx, tissue.coefficient(photon.position())));
    }
    return photon;
}

#endif //MC_SIMULATION_MC_RANDOMWALK_CUH
