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