#include <curand_kernel.h>
#include <array>
#include <vector>
#include <QVector>
#include "code/headers/MC_Photon.cuh"
#include "code/headers/MC_Detector.cuh"
#include "code/headers/MC_RNG.cuh"
#include "code/headers/MC_Tissue.cuh"
#include "code/headers/MC_Kernels.cuh"
#include "code/headers/MC_Helpers.cuh"
#include "code/headers/MC_MLTissue.cuh"
#include "Network/Client/Headers/ClientSocket.h"
#define THREADS_PER_BLOCK 1024
#define DETECTOR_LOOK_AT MC_Vector(0.f, 0.f, -1.f)
int  Number_of_photons;
float Detector_Radius;
float Tissue_Radius;
float Tissue_Absorption_Coefficient;
float Tissue_Scattering_Coefficient;
std::vector<float> coefficients1;
std::vector<float> coefficients2;
MC_Point Detector_Position;
MC_Point Tissue_Center_1;
MC_Point Tissue_Center_2;
void dumpReceivedParameters(QVector<float> parameters);


int main() {
    ClientSocket* socket = new ClientSocket();
    QVector<float> parameters = socket->requestParameters();
    dumpReceivedParameters(parameters);
    socket->setBatchPhotons(Number_of_photons);
    MC_RNG rng;
    MC_Detector detector = MC_Detector(Detector_Radius, Detector_Position, DETECTOR_LOOK_AT);
    //std::vector<float> coefficients1 = {1.f, 6.f, 4.f, 15};
    //std::vector<float> coefficients2 = {100.f, 30.f, 12.f, 44.f};
    MC_MLTissue mlTissue = MC_MLTissue(Tissue_Radius, Tissue_Center_1, Tissue_Center_2, coefficients1, coefficients2);
    //MC_Tissue tissue = MC_Tissue(Tissue_Radius,Tissue_Center_1,Tissue_Center_2,Tissue_Absorption_Coefficient,Tissue_Scattering_Coefficient);
    QVector<MC_Photon> totalPhotonsSent;

    while(socket->getBatchAvailability()){
    	int nBlocks = Number_of_photons + THREADS_PER_BLOCK - 1 / THREADS_PER_BLOCK;
	curandState_t *states;
    	cudaMalloc((void **) &states, Number_of_photons * sizeof(curandState_t));
	auto *_cpuPhotons = (MC_Photon *) malloc(sizeof(MC_Photon) * Number_of_photons);
        MC_Photon *_gpuPhotons = nullptr;
        cudaMalloc((void **) &_gpuPhotons, Number_of_photons * sizeof(MC_Photon));
        MCKernels::simulate<<<nBlocks, THREADS_PER_BLOCK >>>
                                                           (time(nullptr), states, _gpuPhotons, detector, rng, mlTissue, Number_of_photons);
        cudaMemcpy(_cpuPhotons, _gpuPhotons, Number_of_photons * sizeof(MC_Photon), cudaMemcpyDeviceToHost);
        socket->sendResults(&_cpuPhotons[0]);
        //MCHelpers::streamOut(&_cpuPhotons[0], Number_of_photons);
        totalPhotonsSent.append(socket->getSentPhotons());
        Number_of_photons = socket->requestNewBatch();
        free(_cpuPhotons);
        cudaFree(_gpuPhotons);
     	cudaFree(states);
    }
 
    MCHelpers::streamOut(totalPhotonsSent);
    return 0;
}


void dumpReceivedParameters(QVector<float> parameters){
    Number_of_photons = (int) parameters[0];
    Detector_Radius  = parameters[1];
    Detector_Position = MC_Point(parameters[2],parameters[3],parameters[4]);
    Tissue_Radius = parameters[5];
    Tissue_Center_1 =  MC_Point(parameters[6], parameters[7], parameters[8]);
    Tissue_Center_2 = MC_Point(parameters[9],parameters[10],parameters[11]);
    int reminder = (parameters.size()-12)/2;
    for(int i = 12; i<=(11+reminder);i++){
        coefficients1.push_back(parameters[i]);
    }
   for(int i = parameters.size()-1;i>=parameters.size()-reminder;i--){
       coefficients2.push_back(parameters[i]);
   }
   std::reverse(coefficients2.begin(),coefficients2.end());
}
