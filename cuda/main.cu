#include "code/headers/randomwalk.h"
<<<<<<< HEAD:main.cu
#include "Network/Client/Headers/socket.h"
#include <QDebug>
#include <QVector>
=======
#include <sstream>

#define NUMBER_OF_PHOTONS 1000
>>>>>>> origin/master:cuda/main.cu
#define THREADS_PER_BLOCK 1024
#define DETECTOR_LOOK_DOWNWARDS Vector(0.f, 0.f, -1.f)

/*#define NUMBER_OF_PHOTONS 10
#define DETECTOR_RADIUS 10.f
#define DETECTOR_POSITION Point(0.f, 0.f, 50.f)
<<<<<<< HEAD:main.cu
=======
#define DETECTOR_LOOKAT Vector(0.f, 0.f, -1.f)
>>>>>>> origin/master:cuda/main.cu
#define TISSUE_RADIUS 100.f
#define TISSUE_ABSORBTION_COEFFICIENT 1.f
#define TISSUE_SCATTERING_COEFFICIENT 100.f
#define TISSUE_CENTER_1 Point(0.f, 0.f, 50.f)
<<<<<<< HEAD:main.cu
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
bool newBatchAvailable;
char *stateToString(int state);
void streamOut(Photon *_cpuPhotons);
void sendResults(Photon *_cpuPhotons);
void requestParameters();
void populateParameters(QVector<float> parameters);
void applyMC();
void askForNewBatch();
=======
#define TISSUE_CENTER_2 Point(0.f, 0.f, -50.f)



void streamOut(Photon *_cpuPhotons);

>>>>>>> origin/master:cuda/main.cu
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
<<<<<<< HEAD:main.cu
    requestParameters();
    while(newBatchAvailable){
        applyMC();
    }
   // applyMC();
    return 0;
}

void applyMC(){
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
    //Boundary boundary = Boundary(BOUNDARY_RADIUS, Point());
    Detector detector = Detector(detectorRadius, detectorPosition, DETECTOR_LOOK_DOWNWARDS);
    Tissue tissue = Tissue(tissueRadius, tissueFirstCenter, tissueSecondCenter, tissueAbsCoeff, tissueScatCoeff);
    // Kernel Call
    //finalPosition<<<nBlocks,THREADS_PER_BLOCK>>>(time(0), states , _gpuPoints, boundary, rng, NUMBER_OF_PHOTONS);
    finalState<<<nBlocks, THREADS_PER_BLOCK>>>(time(0), states, _gpuPhotons, detector, rng, tissue, numberOfPhotons);
    // Copy device data to host memory to stream them out
    cudaMemcpy(_cpuPhotons, _gpuPhotons, numberOfPhotons * sizeof(Photon), cudaMemcpyDeviceToHost);
=======
    int nBlocks = NUMBER_OF_PHOTONS + THREADS_PER_BLOCK - 1 / THREADS_PER_BLOCK;
    curandState_t *states;
    cudaMalloc((void **)&states, NUMBER_OF_PHOTONS * sizeof(curandState_t));
    Photon *_cpuPhotons = (Photon *)malloc(sizeof(Photon) * NUMBER_OF_PHOTONS);
    Photon *_gpuPhotons = nullptr;
    cudaMalloc((void **)&_gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon));
    RNG rng;
    Detector detector = Detector(DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOKAT);
    Tissue tissue = Tissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, TISSUE_ABSORBTION_COEFFICIENT, TISSUE_SCATTERING_COEFFICIENT);
    finalState<<<nBlocks, THREADS_PER_BLOCK>>>(time(0), states, _gpuPhotons, detector, rng, tissue, NUMBER_OF_PHOTONS);
    cudaMemcpy(_cpuPhotons, _gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon), cudaMemcpyDeviceToHost);
>>>>>>> origin/master:cuda/main.cu
    streamOut(&_cpuPhotons[0]);
    sendResults(&_cpuPhotons[0]);
    askForNewBatch();
    free(_cpuPhotons);
    cudaFree(_gpuPhotons);
<<<<<<< HEAD:main.cu
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
=======
    cudaFree(states);
    return 0;
>>>>>>> origin/master:cuda/main.cu
}

void streamOut(Photon *_cpuPhotons)
{
    FILE *output;
    output = fopen("Results.csv", "w");
    std::string state;
<<<<<<< HEAD:main.cu
    fprintf(output, "X,Y,Z,WEIGHT,STATE\n");
    for (int i = 0; i < numberOfPhotons; i++)
=======
    //Header
    fprintf(output, "%s,%s,%s,%s,%s\n", "X", "Y", "Z", "Weight", "State");
    for (int i = 0; i < NUMBER_OF_PHOTONS; i++)
>>>>>>> origin/master:cuda/main.cu
    {
        switch (_cpuPhotons[i].getState())
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
        fprintf(output, "%f,%f,%f,%f,%s\n", _cpuPhotons[i].getPosition().x(), _cpuPhotons[i].getPosition().y(), _cpuPhotons[i].getPosition().z(), _cpuPhotons[i].getWeight(), state.c_str());
        //qDebug()<< _cpuPhotons[i].getPosition().x()<< _cpuPhotons[i].getPosition().y()<< _cpuPhotons[i].getPosition().z()<< _cpuPhotons[i].getWeight()<< state.c_str();


    }
}



