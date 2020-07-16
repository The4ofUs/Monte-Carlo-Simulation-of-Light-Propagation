//
// Created by mustafa on 6/3/20.
//

#include "../headers/MC_Photon.cuh"
#include "../headers/MC_Helpers.cuh"

void MCHelpers::streamOut(MC_Photon *_cpuPhotons, int n) {
    FILE *output;
    output = fopen("Results.csv", "w");
    std::string state;
    //Header
    fprintf(output, "%s,%s,%s,%s,%s\n", "X", "Y", "Z", "Weight", "State");
    for (int i = 0; i < n; i++) {
        switch (_cpuPhotons[i].state()) {
            case (MC_Photon::TERMINATED):
                state = "TERMINATED";
                break;
            case (MC_Photon::ROAMING):
                state = "ROAMING";
                break;
            case (MC_Photon::DETECTED):
                state = "DETECTED";
                break;
            case (MC_Photon::ESCAPED):
                state = "ESCAPED";
                break;
        }
        // Streaming out my output in a log file
        fprintf(output, "%f,%f,%f,%f,%s\n", _cpuPhotons[i].position().x(), _cpuPhotons[i].position().y(),
                _cpuPhotons[i].position().z(), _cpuPhotons[i].weight(), state.c_str());
    }
}

void
MCHelpers::endMsg(int p_n, float d_r, MC_Point d_p, MC_Vector d_n, float t_r, float t_ac, float t_sc, MC_Point t_c1,
                  MC_Point t_c2) {
    printf("\nSimulation Parameters:\n\n\tGeneral Parameters:\n\t\tNumber of Photons: %i\n\n\tDetector Parameters:\n\t\tRadius: %4.1f\n\t\tPosition: ( %4.1f, %4.1f, %4.1f )\n\t\tNormal: ( %4.1f, %4.1f, %4.1f )\n\n\tTissue Parameters:\n\t\tRadius: %4.1f\n\t\tAbsorption Coefficient: %4.1f\n\t\tScattering Coefficient: %4.1f\n\t\tCenter #1: ( %4.1f, %4.1f, %4.1f )\n\t\tCenter #2: ( %4.1f, %4.1f, %4.1f )\n\nCode executed successfully!\n",
           p_n, d_r, d_p.x(), d_p.y(), d_p.z(), d_n.x(), d_n.y(), d_n.z(), t_r, t_ac, t_sc, t_c1.x(), t_c1.y(),
           t_c1.z(), t_c2.x(), t_c2.y(), t_c2.z());
}