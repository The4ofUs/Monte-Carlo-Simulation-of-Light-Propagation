#include <curand_kernel.h>
#include "code/headers/MC_Photon.cuh"
#include "code/headers/MC_Detector.cuh"
#include "code/headers/MC_RNG.cuh"
#include "code/headers/MC_Tissue.cuh"
#include "code/headers/MC_Kernels.cuh"
#include "code/headers/MC_Helpers.cuh"
#include "code/headers/MC_MLTissue.cuh"

#define NUMBER_OF_PHOTONS 1000
#define THREADS_PER_BLOCK 1024
#define DETECTOR_RADIUS 10.f
#define DETECTOR_POSITION MC_Point(0.f, 0.f, 10.f)
#define DETECTOR_LOOK_AT MC_Vector(0.f, 0.f, -1.f)
#define TISSUE_RADIUS 100.f
#define TISSUE_ABSORPTION_COEFFICIENT 1.f
#define TISSUE_SCATTERING_COEFFICIENT 100.f
#define TISSUE_CENTER_1 MC_Point(0.f, 0.f, 10.f)
#define TISSUE_CENTER_2 MC_Point(0.f, 0.f, -10.f)


int main() {
    printf("main(): Starting.");
    int nBlocks = NUMBER_OF_PHOTONS + THREADS_PER_BLOCK - 1 / THREADS_PER_BLOCK;
    curandState_t *states;
    cudaMalloc((void **) &states, NUMBER_OF_PHOTONS * sizeof(curandState_t));
    auto *_cpuPhotons = (MC_Photon *) malloc(sizeof(MC_Photon) * NUMBER_OF_PHOTONS);
    MC_Photon *_gpuPhotons = nullptr;
    cudaMalloc((void **) &_gpuPhotons, NUMBER_OF_PHOTONS * sizeof(MC_Photon));
    MC_RNG rng;
    MC_Detector detector = MC_Detector(DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOK_AT);
    std::vector<float> coefficients1 = {1.f, 6.f, 4.f, 15};
    std::vector<float> coefficients2 = {100.f, 30.f, 12.f, 44.f};
    MC_MLTissue mlTissue = MC_MLTissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, coefficients1, coefficients2);
    MC_Tissue tissue = MC_Tissue(TISSUE_RADIUS,TISSUE_CENTER_1,TISSUE_CENTER_2,TISSUE_ABSORPTION_COEFFICIENT,TISSUE_SCATTERING_COEFFICIENT);
    MCKernels::simulate <<<nBlocks, THREADS_PER_BLOCK>>> (time(nullptr), states, _gpuPhotons, detector, rng, tissue, NUMBER_OF_PHOTONS);
    cudaMemcpy(_cpuPhotons, _gpuPhotons, NUMBER_OF_PHOTONS * sizeof(MC_Photon), cudaMemcpyDeviceToHost);
    MCHelpers::streamOut(&_cpuPhotons[0], NUMBER_OF_PHOTONS);
    MCHelpers::endMsg(NUMBER_OF_PHOTONS,DETECTOR_RADIUS,DETECTOR_POSITION,DETECTOR_LOOK_AT,TISSUE_RADIUS,TISSUE_ABSORPTION_COEFFICIENT,TISSUE_SCATTERING_COEFFICIENT,TISSUE_CENTER_1,TISSUE_CENTER_2);
    free(_cpuPhotons);
    cudaFree(_gpuPhotons);
    cudaFree(states);
    return 0;
}


