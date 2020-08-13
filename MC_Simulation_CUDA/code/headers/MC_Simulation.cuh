//
// Created by mostafa on ٢‏/٨‏/٢٠٢٠.
//

#ifndef MC_SIMULATION_MC_SIMULATION_CUH
#define MC_SIMULATION_MC_SIMULATION_CUH


#include "MC_RNG.cuh"
#include "MC_FiberGenerator.cuh"
#include "MC_MLTissue.cuh"
#include "MC_Math.cuh"
#include <QVector>

//#define NUMBER_OF_PHOTONS 10000
#define THREADS_PER_BLOCK 512
//#define MC_FIBER_GENERATOR_RADIUS 1.f
//#define MC_FIBER_GENERATOR_POSITION MC_Point(0.f, 0.f, 1.f)
#define MC_FIBER_GENERATOR_NORMAL MC_Vector(0.f, 0.f, -1.f)
//#define TISSUE_RADIUS 100.f
//#define TISSUE_CENTER_1 MC_Point(0.f, 0.f, 1.f)
//#define TISSUE_CENTER_2 MC_Point(0.f, 0.f, 0.f)
//#define A_COEFFICIENTS std::vector<float> {0.2f, 0.1f, 5.f, 19.f}
//#define S_COEFFICIENTS std::vector<float> {50.f, 90.f, 10.f, 20.f}
//#define R_INDICES std::vector<float> {1.2f, 1.5f, 1.6f, 1.7f}


class MC_Simulation {
public:
    MC_Simulation(float MC_FIBER_GENERATOR_RADIUS, MC_Point MC_FIBER_GENERATOR_POSITION, float TISSUE_RADIUS, MC_Point TISSUE_CENTER_1, MC_Point TISSUE_CENTER_2
                  , std::vector<float>A_COEFFICIENTS, std::vector<float>S_COEFFICIENTS,std::vector<float>R_INDICES);

    void start(int NUMBER_OF_PHOTONS);

    bool _batchAvailability = true;
    QVector<MC_Photon> _totalPhotonsPerPatch;


private:
    MC_FiberGenerator _mcFiberGenerator;
    MC_MLTissue _mcMLTissue;
};


#endif //MC_SIMULATION_MC_SIMULATION_CUH
