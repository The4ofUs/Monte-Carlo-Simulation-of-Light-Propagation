#include "code/headers/randomwalk.h"
#include <sstream>
#include <iostream>

int NUMBER_OF_PHOTONS = 10000;
float DETECTOR_RADIUS = 10.f;
Point DETECTOR_POSITION = Point(0.f, 0.f, 50.f);
Vector DETECTOR_LOOKAT = Vector(0.f, 0.f, -1.f);
float TISSUE_RADIUS = 100.f;
float TISSUE_ABSORBTION_COEFFICIENT = 1.f;
float TISSUE_SCATTERING_COEFFICIENT = 100.f;
Point TISSUE_CENTER_1 = Point(0.f, 0.f, 50.f);
Point TISSUE_CENTER_2 = Point(0.f, 0.f, -50.f);
Point SOURCE_POSITION = Point(0.f, 0.f, 50.f);
Vector SOURCE_LOOKAT = Vector(0.f, 0.f, -1.f);


void streamOut(Photon *_cpuPhotons);
char *stateToString(int state);

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

    // Get starting point exact time
    auto start = std::chrono::high_resolution_clock::now();
    // Pass Variables to begin the randomWalk
    finalState(&_cpuPhotons[0], detector, rng, tissue);
    // End point exact time
    auto stop = std::chrono::high_resolution_clock::now();
    // Calculate duration
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start);
    std::cout << "Execution time: " << duration.count() << "ms"
              << "\n";

    //Stream the results out
    streamOut(&_cpuPhotons[0]);
    delete[] _cpuPhotons;

    return 0;
}

void streamOut(Photon *_cpuPhotons)
{
    FILE *output;
    output = fopen("output.csv", "w");
    std::string state;
    // Adding Meta-data to the output file
    /*
    *   This Particular order should be maintained if the output was to be read using the Plotter 
    */
    //fprintf(output, "X, Y, Z, WEIGHT, STATE,photon_num,%i,threads_per_block,%i,detector_radius,%f,detector_pos,%f,%f,%f,detector_lookAt,%f,%f,%f,tissue_radius,%f,absorp_coeff,%f,scatter_coeff,%f,tissue_center_1,%f,%f,%f,tissue_center_2,%f,%f,%f\n", NUMBER_OF_PHOTONS, 10, DETECTOR_RADIUS, DETECTOR_POSITION.x(), DETECTOR_POSITION.y(), DETECTOR_POSITION.z(), DETECTOR_LOOKAT.x(), DETECTOR_LOOKAT.y(), DETECTOR_LOOKAT.z(), TISSUE_RADIUS, TISSUE_ABSORBTION_COEFFICIENT, TISSUE_SCATTERING_COEFFICIENT, TISSUE_CENTER_1.x(), TISSUE_CENTER_1.y(), TISSUE_CENTER_1.z(), TISSUE_CENTER_2.x(), TISSUE_CENTER_2.y(), TISSUE_CENTER_2.z());

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
        //Streaming out my output in terminal
        // std::cout << _cpuPhotons[i].getPosition().x()<<','<<_cpuPhotons[i].getPosition().y()<<','<< _cpuPhotons[i].getPosition().z()<<','<<_cpuPhotons[i].getWeight()<<','<< state.c_str() << '\n';
        //Streaming out my output in a log file
        fprintf(output, "%f,%f,%f,%f,%s\n", _cpuPhotons[i].getPosition().x(), _cpuPhotons[i].getPosition().y(), _cpuPhotons[i].getPosition().z(), _cpuPhotons[i].getWeight(), state.c_str());
    }
}

