//
// Created by mostafa on ٢‏/٨‏/٢٠٢٠.
//

#ifndef MC_SIMULATION_MC_SIMULATION_CUH
#define MC_SIMULATION_MC_SIMULATION_CUH


#include "MC_RNG.cuh"
#include "MC_FiberGenerator.cuh"
#include "MC_MLTissue.cuh"
#include <cmath>

#define NUMBER_OF_PHOTONS 10000
#define THREADS_PER_BLOCK 512
#define MC_FIBER_GENERATOR_RADIUS 1.f
#define MC_FIBER_GENERATOR_POSITION MC_Point(0.f, 0.f, 1.f)
#define MC_FIBER_GENERATOR_NORMAL MC_Vector(0.f, 0.f, -1.f)
#define TISSUE_RADIUS 100.f
#define TISSUE_CENTER_1 MC_Point(0.f, 0.f, 1.f)
#define TISSUE_CENTER_2 MC_Point(0.f, 0.f, 0.f)
#define A_COEFFICIENTS std::vector<float> {0.18f, 0.16f, 0.04f, 0.66f}
#define S_COEFFICIENTS std::vector<float> {19.f, 16.f, 2.4f, 110.5f}
#define R_INDICES std::vector<float> {1.4f,1.4f, 1.4f, 1.4f}


class MC_Simulation {
public:
    MC_Simulation();

    void start();

private:
    MC_FiberGenerator _mcFiberGenerator;
    MC_MLTissue _mcMLTissue;
};


#endif //MC_SIMULATION_MC_SIMULATION_CUH
