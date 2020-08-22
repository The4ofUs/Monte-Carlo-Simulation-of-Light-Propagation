//
// Created by mostafa on ٢‏/٨‏/٢٠٢٠.
//

#include "../headers/MC_Simulation.cuh"
#include "../headers/MC_Kernels.cuh"
#include "../headers/MC_Helpers.cuh"
#include "../../clientSide/headers/ClientSocket.h"
#include <QVector>

MC_Simulation::MC_Simulation(float MC_FIBER_GENERATOR_RADIUS, MC_Point MC_FIBER_GENERATOR_POSITION, float TISSUE_RADIUS, MC_Point TISSUE_CENTER_1, MC_Point TISSUE_CENTER_2
                             , std::vector<float>A_COEFFICIENTS, std::vector<float>S_COEFFICIENTS, std::vector<float> R_INDICES) {
    _mcFiberGenerator = MC_FiberGenerator(MC_FIBER_GENERATOR_RADIUS, MC_FIBER_GENERATOR_POSITION, MC_FIBER_GENERATOR_NORMAL);
    _mcMLTissue = MC_MLTissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, A_COEFFICIENTS, S_COEFFICIENTS,
                              R_INDICES);
}


void MC_Simulation::start(int NUMBER_OF_PHOTONS) {
    _totalPhotonsPerPatch.clear();
    ClientSocket* socket = new ClientSocket();
    socket->setBatchPhotons(NUMBER_OF_PHOTONS);
    int blocksCount = NUMBER_OF_PHOTONS + THREADS_PER_BLOCK - 1 / THREADS_PER_BLOCK;
    curandState_t *states;
    cudaMalloc((void **) &states, NUMBER_OF_PHOTONS * sizeof(curandState_t));
    auto *hostMemory = (MC_Photon *) malloc(sizeof(MC_Photon) * NUMBER_OF_PHOTONS);
    MC_Photon *deviceMemory = nullptr;
    cudaMalloc((void **) &deviceMemory, NUMBER_OF_PHOTONS * sizeof(MC_Photon));
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);
    MCKernels::simulate<<<blocksCount, THREADS_PER_BLOCK>>>(time(nullptr), states, deviceMemory, _mcFiberGenerator, _mcMLTissue, NUMBER_OF_PHOTONS);
    cudaEventRecord(stop);
    cudaMemcpy(hostMemory, deviceMemory, NUMBER_OF_PHOTONS * sizeof(MC_Photon), cudaMemcpyDeviceToHost);
    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);
    _totalTime += milliseconds;
    cudaEventDestroy( start );
    cudaEventDestroy( stop );
    socket->sendResults(&hostMemory[0]);
    _totalPhotonsPerPatch.append(socket->getSentPhotons());
    // MCHelpers::streamOut(&hostMemory[0], NUMBER_OF_PHOTONS);
    NUMBER_OF_PHOTONS = socket->requestNewBatch();
   _batchAvailability = socket->getBatchAvailability();
    qDebug()<<"Batch availability flag is "<<_batchAvailability;
    free(hostMemory);
    cudaFree(deviceMemory);
    cudaFree(states);
}
