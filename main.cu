#include "code/headers/randomwalk.h"
#include "Network/Client/Headers/socket.h"
#include <QDebug>
#include <QVector>
#include <unistd.h>
#define THREADS_PER_BLOCK 1024
#define DETECTOR_LOOK_DOWNWARDS Vector(0.f, 0.f, -1.f)

/*#define NUMBER_OF_PHOTONS 10
#define DETECTOR_RADIUS 10.f
#define DETECTOR_POSITION Point(0.f, 0.f, 50.f)
#define TISSUE_RADIUS 100.f
#define TISSUE_ABSORBTION_COEFFICIENT 1.f
#define TISSUE_SCATTERING_COEFFICIENT 100.f
#define TISSUE_CENTER_1 Point(0.f, 0.f, 50.f)
#define TISSUE_CENTER_2 Point(0.f, 0.f, -50.f)*/
int numberOfPhotons;
float detectorRadius;
float tissueRadius;
float tissueAbsCoeff;
float tissueScatCoeff;
Point detectorPosition;
Point tissueFirstCenter;
Point tissueSecondCenter;
QVector<Photon> photons;
QVector<Photon> totalSentResults;
QVector<float> X;
QVector<float> Y;
QVector<float> Z;
QVector<float> W;
QVector<int> ST;

bool newBatchAvailable;
char *stateToString(int state);
void sendResults(Photon *_cpuPhotons);
void requestParameters();
void populateParameters(QVector<float> parameters);
void applyMC(Detector detector, Tissue tissue);
void askForNewBatch();
void appendToVectors(QVector<Photon> Photons);
void streamOut(QVector<Photon> results);

__global__ void finalState(unsigned int seed, curandState_t *states, Photon *_gpuPhotons, Detector detector, RNG rng, Tissue tissue, int n)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n)
    {
        curand_init(seed, idx, 0, &states[idx]);
        Photon finalState = randomWalk(states, idx, detector, rng, tissue);
        _gpuPhotons[idx] = finalState;
    }
}


int main()
{
    requestParameters();
    //Boundary boundary = Boundary(BOUNDARY_RADIUS, Point());
    Detector detector = Detector(detectorRadius, detectorPosition, DETECTOR_LOOK_DOWNWARDS);
    Tissue tissue = Tissue(tissueRadius, tissueFirstCenter, tissueSecondCenter, tissueAbsCoeff, tissueScatCoeff);
    while(newBatchAvailable){
        applyMC(detector, tissue);
        usleep(1000000);
    }

   // applyMC();
    streamOut(totalSentResults);
    return 0;
}

void applyMC(Detector detector, Tissue tissue){
    int nBlocks = numberOfPhotons / THREADS_PER_BLOCK + 1;
    curandState_t *states;
    cudaMalloc((void **)&states, numberOfPhotons * sizeof(curandState_t));
    // Allocate host memory for final positions
    Photon *_cpuPhotons = (Photon *)malloc(sizeof(Photon) * numberOfPhotons);
    // Allocate device  memory for final positions
    Photon *_gpuPhotons = nullptr;
    cudaMalloc((void **)&_gpuPhotons, numberOfPhotons * sizeof(Photon));
    // Initialize the Boundary and the RandomNumberGenerator
    RNG rng;

    // Kernel Call
    //finalPosition<<<nBlocks,THREADS_PER_BLOCK>>>(time(0), states , _gpuPoints, boundary, rng, NUMBER_OF_PHOTONS);
    finalState<<<nBlocks, THREADS_PER_BLOCK>>>(time(0), states, _gpuPhotons, detector, rng, tissue, numberOfPhotons);
    // Copy device data to host memory to stream them out
    cudaMemcpy(_cpuPhotons, _gpuPhotons, numberOfPhotons * sizeof(Photon), cudaMemcpyDeviceToHost);
    //streamOut(&_cpuPhotons[0]);
    sendResults(&_cpuPhotons[0]);
    askForNewBatch();
    free(_cpuPhotons);
    cudaFree(_gpuPhotons);
}





void sendResults(Photon *_cpuPhotons){

    QVector<Photon> vectorOfPhotons;
    for (int i = 0; i < numberOfPhotons; i++)
    {
        vectorOfPhotons.push_back(_cpuPhotons[i]);
    }
    socket *newSocket =new socket();
    newSocket->queryType="prepareForReceiving";
    newSocket->socket::getVectorOfPhotons(vectorOfPhotons);
    newSocket->createSocket();
    appendToVectors(vectorOfPhotons);

}


void requestParameters(){
    socket *newSocket =new socket();
    newSocket->queryType="requestParameters";
    newSocket->createSocket();
    QVector<float> parameters = newSocket->getParameters();
    //qDebug()<<parameters<<parameters.size();
    if(parameters.size()>0){
        populateParameters(parameters);
        newBatchAvailable = true;
    }
}

void askForNewBatch(){
    socket *newSocket =new socket();
    newSocket->queryType="requestBatch";
    newSocket->createSocket();
    numberOfPhotons = newSocket->numberOfPhotons;
    if (numberOfPhotons==0){
        newBatchAvailable = false;
    }
}

void populateParameters(QVector<float> parameters){
    numberOfPhotons = (int) parameters[0];
    detectorRadius  = parameters[1];
    detectorPosition = Point(parameters[2],parameters[3],parameters[4]);
    tissueRadius = parameters[5];
    tissueAbsCoeff = parameters[6];
    tissueScatCoeff = parameters[7];
    tissueFirstCenter =  Point(parameters[8], parameters[9], parameters[10]);
    tissueSecondCenter = Point(parameters[11],parameters[12],parameters[13]);
    qDebug()<<"Parameters are received";
}

// Append photons of each patch to a vector to stream the whole photons at the client side in 1 file
// This is used in testing phase only
void appendToVectors(QVector<Photon> Photons){
  totalSentResults.append(Photons);
  qDebug()<<"total sent"<<totalSentResults.size();
}



void streamOut(QVector<Photon> results){
    FILE *output;
    output = fopen("clientSentPhotons.csv", "w");
    std::string state;
    fprintf(output, "X,Y,Z,WEIGHT,STATE\n");

    for (int i = 0; i < results.size(); i++)
    {
        switch (results[i].getState())
        {
        case (-1):
            state = "TERMINATED";
            break;
        case (0):
            state = "ROAMING";
            break;
        case (1):
            state = "DETECTED";
            break;
        case (2):
            state = "ESCAPED";
            break;
        }

        // Streaming out my output in a log file
        fprintf(output, "%f,%f,%f,%f,%s\n", results[i].getPosition().x(), results[i].getPosition().y(), results[i].getPosition().z(), results[i].getWeight(), state.c_str());
       // qDebug()<<results[i].getPosition().x()<< results[i].getPosition().y()<< results[i].getPosition().z()<< results[i].getWeight()<< state.c_str();

    }
    fclose(output);
}
