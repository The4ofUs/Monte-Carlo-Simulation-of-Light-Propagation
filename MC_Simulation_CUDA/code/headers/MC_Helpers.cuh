//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_HELPERS_CUH
#define MC_SIMULATION_MC_HELPERS_CUH

#include "MC_Photon.cuh"
#include <sstream>

namespace MCHelpers {
    void streamOut(MC_Photon *_cpuPhotons, int n);
}


#endif //MC_SIMULATION_MC_HELPERS_CUH
