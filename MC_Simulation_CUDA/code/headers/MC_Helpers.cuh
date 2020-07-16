//
// Created by mustafa on 6/3/20.
//

#ifndef MC_SIMULATION_MC_HELPERS_CUH
#define MC_SIMULATION_MC_HELPERS_CUH

#include "MC_Photon.cuh"
#include <sstream>

namespace MCHelpers {
    void streamOut(MC_Photon *_cpuPhotons, int n);
    void endMsg(int const p_n, float const d_r, MC_Point const d_p, MC_Vector const d_n, float const t_r, float const t_ac, float const t_sc, MC_Point const t_c1, MC_Point const t_c2);
}


#endif //MC_SIMULATION_MC_HELPERS_CUH
