#include "code/headers/randomwalk.h"

//#define NUMBER_OF_PHOTONS 1000
#define DETECTOR_RADIUS 10.f
#define DETECTOR_POSITION Point(0.f, 0.f, 50.f)
#define DETECTOR_LOOKAT Vector(0.f, 0.f, -1.f)
#define TISSUE_RADIUS 1000.f
//#define TISSUE_ABSORBTION_COEFFICIENT 1.f
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

void streamOut(int a, float c, float d, unsigned long long int e, unsigned long long int f, float g, float h, float i)
{
    FILE *output;
    output = fopen("metrics.csv", "a");
    if (output != NULL)
    {
        fprintf(output, "%i, %f, %f, %llu, %llu, %f, %f, %f\n", a, c, d, e, f, g, h, i);
        fclose(output);
    }
    else
    {
        std::cout << "Failed to open file, retrying!" << std::endl;
        streamOut(a, c, d, e, f, g, h, i);
    }
}

void run(int n, float Ma)
{
    int NUMBER_OF_PHOTONS = n;
    float TISSUE_ABSORBTION_COEFFICIENT = Ma;
    unsigned int NUMBER_OF_TEST_RUNS = 100;
    float totalTime = 0.f;
    unsigned long long int totalLifetime = 0;
    float detectedRatio = 0.f;
    float terminatedRatio = 0.f;
    float escapedRatio = 0.f;
    for (int i = 0; i < NUMBER_OF_TEST_RUNS; i++)
    {
        RNG rng;
        Detector detector = Detector(DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOKAT);
        Tissue tissue = Tissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, TISSUE_ABSORBTION_COEFFICIENT, TISSUE_SCATTERING_COEFFICIENT);
        Photon *_cpuPhotons;
        _cpuPhotons = new Photon[NUMBER_OF_PHOTONS];
        auto start = std::chrono::high_resolution_clock::now();
        finalState(&_cpuPhotons[0], detector, rng, tissue, NUMBER_OF_PHOTONS);
        auto stop = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
        totalTime += duration.count();
        for (int j = 0; j < NUMBER_OF_PHOTONS; j++)
        {
            totalLifetime += _cpuPhotons[j].getLifetime();
            if (_cpuPhotons[j].getState() == Photon::DETECTED)
            {
                detectedRatio += 1;
            }
            else if (_cpuPhotons[j].getState() == Photon::TERMINATED)
            {
                terminatedRatio += 1;
            }
            else
            {
                escapedRatio += 1;
            }
        }
        delete[] _cpuPhotons;
    }
    streamOut(NUMBER_OF_PHOTONS, (TISSUE_ABSORBTION_COEFFICIENT + TISSUE_SCATTERING_COEFFICIENT), (totalTime / NUMBER_OF_TEST_RUNS), (totalLifetime / NUMBER_OF_TEST_RUNS), (totalLifetime / NUMBER_OF_TEST_RUNS) / NUMBER_OF_PHOTONS, ((detectedRatio / NUMBER_OF_TEST_RUNS) / NUMBER_OF_PHOTONS), ((terminatedRatio / NUMBER_OF_TEST_RUNS) / NUMBER_OF_PHOTONS), ((escapedRatio / NUMBER_OF_TEST_RUNS) / NUMBER_OF_PHOTONS));
}

int main()
{
    int number[] = {1, 10, 100};
    float coefficients[] = {100, 1000, 10000};
    for (int i = 0; i < (sizeof(number) / sizeof(int)); i++)
    {
        for (int j = 0; j < (sizeof(coefficients) / sizeof(float)); j++)
        {
            run(number[i], coefficients[j]);
        }
    }
    return 0;
}
