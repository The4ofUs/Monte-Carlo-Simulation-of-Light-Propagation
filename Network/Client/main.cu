#include <curand_kernel.h>
#include <vector>
#include <QVector>
#include "clientSide/headers/ClientSocket.h"
#include "code/headers/MC_Simulation.cuh"
#include "code/headers/MC_Helpers.cuh"



int  Number_of_photons;
float fiber_generator_radius;
float tissue_radius;

std::vector<float> a_coeffiecints;
std::vector<float> s_coefficients;
std::vector<float>refractive_indices;

MC_Point fiber_generator_poistion;
MC_Point tissue_center_1;
MC_Point tissue_center_2;

void dumpReceivedParameters(QVector<float> parameters);

QVector<MC_Photon> total_photons_sent;


int main() {
    ClientSocket* socket = new ClientSocket();
    QVector<float> parameters = socket->requestParameters();
    dumpReceivedParameters(parameters);
    MC_Simulation simulation = MC_Simulation(fiber_generator_radius, fiber_generator_poistion, tissue_radius, tissue_center_1, tissue_center_2, a_coeffiecints, s_coefficients, refractive_indices);
    while(simulation._batchAvailability){
         simulation.start(Number_of_photons);
         total_photons_sent.append(simulation._totalPhotonsPerPatch);
    }
    qDebug() <<"Total execution time = " << simulation._totalTime << "ms";
    qDebug() <<"Total number of simulated photons = " << total_photons_sent.size();
    MCHelpers::streamOut(total_photons_sent);
    return 0;
}


void dumpReceivedParameters(QVector<float> parameters){
    Number_of_photons = (int) parameters[0];
    fiber_generator_radius = parameters[1];
    fiber_generator_poistion = MC_Point(parameters[2],parameters[3],parameters[4]);
    tissue_radius = parameters[5];
    tissue_center_1 =  MC_Point(parameters[6], parameters[7], parameters[8]);
    tissue_center_2 = MC_Point(parameters[9],parameters[10],parameters[11]);
    int reminder = (parameters.size()-12)/3;
    for(int i = 12; i<=(11+reminder);i++){
            a_coeffiecints.push_back(parameters[i]);
    }
    for(int i = 12+reminder;i<=11+2*reminder;i++){
           s_coefficients.push_back(parameters[i]);
    }
    for(int i =12+2*reminder;i<=parameters.size()-1;i++){
           refractive_indices.push_back(parameters[i]);
    }
}

