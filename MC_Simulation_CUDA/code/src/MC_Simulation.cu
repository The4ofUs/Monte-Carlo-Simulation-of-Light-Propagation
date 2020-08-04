//
// Created by mostafa on ٢‏/٨‏/٢٠٢٠.
//

#include "../headers/MC_Simulation.cuh"
#include "../headers/MC_Kernels.cuh"
#include "../headers/MC_Helpers.cuh"


MC_Simulation::MC_Simulation(){
    detector = MC_Detector(DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOK_AT);
    mlTissue = MC_MLTissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, COEFFICIENTS1, COEFFICIENTS2);
}

void MC_Simulation::start() {
    int blocksCount = NUMBER_OF_PHOTONS + THREADS_PER_BLOCK - 1 / THREADS_PER_BLOCK;
    curandState_t *states;
    cudaMalloc((void **) &states, NUMBER_OF_PHOTONS * sizeof(curandState_t));
    auto *_cpuPhotons = (MC_Photon *) malloc(sizeof(MC_Photon) * NUMBER_OF_PHOTONS);
    MC_Photon *_gpuPhotons = nullptr;
    cudaMalloc((void **) &_gpuPhotons, NUMBER_OF_PHOTONS * sizeof(MC_Photon));
    MCKernels::simulate<<<blocksCount, THREADS_PER_BLOCK>>>(time(nullptr), states, _gpuPhotons, detector, rng, mlTissue, NUMBER_OF_PHOTONS);
    cudaMemcpy(_cpuPhotons, _gpuPhotons, NUMBER_OF_PHOTONS * sizeof(MC_Photon), cudaMemcpyDeviceToHost);
    MCHelpers::streamOut(&_cpuPhotons[0], NUMBER_OF_PHOTONS);
    free(_cpuPhotons);
    cudaFree(_gpuPhotons);
    cudaFree(states);
}