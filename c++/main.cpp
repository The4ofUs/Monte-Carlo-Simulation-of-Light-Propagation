#include "code/headers/randomwalk.h"
#include <sstream>
#include <iostream>

#define NUMBER_OF_PHOTONS 10000
#define THREADS_PER_BLOCK 1024
#define DETECTOR_RADIUS 10.f
#define DETECTOR_POSITION Point(0.f, 0.f, 50.f)
#define DETECTOR_LOOKAT Vector(0.f, 0.f, -1.f)
#define TISSUE_RADIUS 100.f
#define TISSUE_ABSORBTION_COEFFICIENT 1.f
#define TISSUE_SCATTERING_COEFFICIENT 100.f
#define TISSUE_CENTER_1 Point(0.f, 0.f, 50.f)
#define TISSUE_CENTER_2 Point(0.f, 0.f, -50.f)

void streamOut(Photon *_cpuPhotons);

void finalState(Photon *_cpuPhotons, Detector detector, RNG rng, Tissue tissue)
{
    for (int i = 0; i < NUMBER_OF_PHOTONS; i++)
    {
        Photon finalState = randomWalk(detector, rng, tissue);
        _cpuPhotons[i] = finalState;
    }
}

int main()
{
    RNG rng;
    Detector detector = Detector(DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOKAT);
    Tissue tissue = Tissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, TISSUE_ABSORBTION_COEFFICIENT, TISSUE_SCATTERING_COEFFICIENT);
    Photon *_cpuPhotons;
    _cpuPhotons = new Photon[NUMBER_OF_PHOTONS];

    finalState(&_cpuPhotons[0], detector, rng, tissue);

    streamOut(&_cpuPhotons[0]);
    delete[] _cpuPhotons;

    return 0;
}

void streamOut(Photon *_cpuPhotons)
{
    FILE *output;
    output = fopen("results.csv", "w");
    std::string state;
    //Header
    fprintf(output, "%s,%s,%s,%s,%s\n", "X", "Y", "Z", "Weight", "State");
    for (int i = 0; i < NUMBER_OF_PHOTONS; i++)
    {
        switch (_cpuPhotons[i].getState())
        {
        case (-1):
            state = "TERMINATED";
            break;
        case (0):
            state = "ROAMING";
            break;
        case (1):
            state = "DETECTED";
            break;
        case (2):
            state = "ESCAPED";
            break;
        }
        fprintf(output, "%f,%f,%f,%f,%s\n", _cpuPhotons[i].getPosition().x(), _cpuPhotons[i].getPosition().y(), _cpuPhotons[i].getPosition().z(), _cpuPhotons[i].getWeight(), state.c_str());
    }
}
