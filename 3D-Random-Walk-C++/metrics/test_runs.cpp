#include "code/headers/randomwalk.h"
#include <sstream>


#define DETECTOR_RADIUS 10.f
#define DETECTOR_POSITION Point(0.f, 0.f, 50.f)
#define DETECTOR_LOOKAT Vector(0.f, 0.f, -1.f)
#define TISSUE_RADIUS 1000.f
#define TISSUE_SCATTERING_COEFFICIENT 100.f
#define TISSUE_CENTER_1 Point(0.f, 0.f, 50.f)
#define TISSUE_CENTER_2 Point(0.f, 0.f, -50.f)

void finalState(Photon *_cpuPhotons, Detector detector, RNG rng, Tissue tissue, int NUMBER_OF_PHOTONS)
{
    for (int i = 0; i < NUMBER_OF_PHOTONS; i++)
    {
        Photon finalState = randomWalk(detector, rng, tissue);
        _cpuPhotons[i] = finalState;
    }
}

void streamOut(int a, float c, float d, float g, float h, float i)
{
    FILE *output;
    output = fopen("metrics.csv", "a");
    if (output != NULL)
    {
        fprintf(output, "%i, %f, %f, %f, %f, %f\n", a, c, d, g, h, i);
        fclose(output);
    }
    else
    {
        std::cout << "Failed to open file, retrying!" << std::endl;
        streamOut(a, c, d, g, h, i);
    }
}

void run(int n, float Ma)
{
    int NUMBER_OF_PHOTONS = n;
    float TISSUE_ABSORBTION_COEFFICIENT = Ma;
    unsigned int NUMBER_OF_TEST_RUNS = 100;
    float totalTime = 0.f;
    float detected = 0.f;
    float terminated = 0.f;
    float escaped = 0.f;
    for (int i = 0; i < NUMBER_OF_TEST_RUNS; i++)
    {   std::cout << "Progress %" << i << "\r";
        RNG rng;
        Detector detector = Detector(DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOKAT);
        Tissue tissue = Tissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, TISSUE_ABSORBTION_COEFFICIENT, TISSUE_SCATTERING_COEFFICIENT);
        Photon *_cpuPhotons;
        _cpuPhotons = new Photon[NUMBER_OF_PHOTONS];
        std::chrono::high_resolution_clock::time_point start = std::chrono::high_resolution_clock::now();
        finalState(&_cpuPhotons[0], detector, rng, tissue, NUMBER_OF_PHOTONS);
        std::chrono::high_resolution_clock::time_point stop = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start);
        totalTime += duration.count();
        for (int j = 0; j < NUMBER_OF_PHOTONS; j++)
        {
            if (_cpuPhotons[j].getState() == Photon::DETECTED)
            {
                detected += 1;
            }
            else if (_cpuPhotons[j].getState() == Photon::TERMINATED)
            {
                terminated += 1;
            }
            else
            {
                escaped += 1;
            }
        }
        delete[] _cpuPhotons;
    }
    std::cout << "Progress %100" ;
    float detectedRatio = ((detected/NUMBER_OF_TEST_RUNS)/NUMBER_OF_PHOTONS);
    float terminatedRatio = ((terminated/NUMBER_OF_TEST_RUNS)/NUMBER_OF_PHOTONS);
    float escapedRatio = ((escaped/NUMBER_OF_TEST_RUNS)/NUMBER_OF_PHOTONS);
    streamOut(NUMBER_OF_PHOTONS, (TISSUE_ABSORBTION_COEFFICIENT + TISSUE_SCATTERING_COEFFICIENT), (totalTime/NUMBER_OF_TEST_RUNS), detectedRatio, terminatedRatio, escapedRatio);
}

int main()
{
    int start = time(NULL);
    int number[] = {1,10,20,50,100,200,500,1000,2000,5000,10000,20000,50000,100000,200000,500000,1000000,2000000,5000000};
    float coefficients[] = {100,1000,10000};
    for(int i = 0; i<(sizeof(number)/sizeof(int)); i++){
        for(int j= 0; j<(sizeof(coefficients)/sizeof(float)); j++){
            run(number[i],coefficients[j]);
            std::cout<<"\t|\t"<< number[i] << "\t|\t" << coefficients[j] << "\t|\t" << time(NULL) - start << " Second(s)" <<  std::endl;
        }
    }
    return 0;
}
