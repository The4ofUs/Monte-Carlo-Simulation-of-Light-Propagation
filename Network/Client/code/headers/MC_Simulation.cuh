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

#define THREADS_PER_BLOCK 512
#define MC_FIBER_GENERATOR_NORMAL MC_Vector(0.f, 0.f, -1.f)



class MC_Simulation {
public:
    MC_Simulation(float MC_FIBER_GENERATOR_RADIUS, MC_Point MC_FIBER_GENERATOR_POSITION, float TISSUE_RADIUS, MC_Point TISSUE_CENTER_1, MC_Point TISSUE_CENTER_2
                  , std::vector<float>A_COEFFICIENTS, std::vector<float>S_COEFFICIENTS,std::vector<float>R_INDICES);

    void start(int NUMBER_OF_PHOTONS);

    bool _batchAvailability = true;
    QVector<MC_Photon> _totalPhotonsPerPatch;
    float _totalTime =0.f;


private:
    MC_FiberGenerator _mcFiberGenerator;
    MC_MLTissue _mcMLTissue;
};


#endif //MC_SIMULATION_MC_SIMULATION_CUH
