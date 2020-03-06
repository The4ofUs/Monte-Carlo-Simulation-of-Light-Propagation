#include "code/headers/randomwalk.h"
#include <sstream>


/*
TO-DO:
    - Loop to execute multiple runs on the same parameters and extract average for every metric produces
*/


unsigned int NUMBER_OF_TEST_RUNS = 100;
int NUMBER_OF_PHOTONS = 0;
int THREADS_PER_BLOCK = 32;
float DETECTOR_RADIUS = 0.f;
Point DETECTOR_POSITION = Point();
Vector DETECTOR_LOOKAT = Vector();
float TISSUE_RADIUS = 0.f;
float TISSUE_ABSORBTION_COEFFICIENT = 0.f;
float TISSUE_SCATTERING_COEFFICIENT = 0.f;
Point TISSUE_CENTER_1 = Point();
Point TISSUE_CENTER_2 = Point();
Point SOURCE_POSITION = Point();
Vector SOURCE_LOOKAT = Vector();



void streamOut(Photon *_cpuPhotons);
char *stateToString(int state);
void printMetrics(cudaEvent_t e1, cudaEvent_t e2, int NUMBER_OF_BLOCKS);

__global__ void finalState(unsigned int seed, curandState_t *states, Photon *_gpuPhotons, Detector dectector, RNG rng, Tissue tissue, int n)
{  
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n)
    {
        curand_init(seed, idx, 0, &states[idx]);
        Photon finalState = randomWalk(states, idx, dectector, rng,  tissue);
        _gpuPhotons[idx] = finalState;        
    }
}

bool parseUserInput(int argc, char *argv[], int &nPhotons, int &nThreads, float &dRadius, Point &dPosition, Vector &dLookAt, float &tRadius, float &tAbsorpCoeff,
    float &tScatterCoeff, Point &tCenter1, Point &tCenter2, Point &pPosition, Vector &pLookAt);

int main( int argc, char *argv[] )
{
    if (parseUserInput(argc, argv ,NUMBER_OF_PHOTONS, THREADS_PER_BLOCK, DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOKAT, TISSUE_RADIUS, 
        TISSUE_ABSORBTION_COEFFICIENT, TISSUE_SCATTERING_COEFFICIENT, TISSUE_CENTER_1, TISSUE_CENTER_2, SOURCE_POSITION, SOURCE_LOOKAT)) {
        int nBlocks = NUMBER_OF_PHOTONS + THREADS_PER_BLOCK - 1 / THREADS_PER_BLOCK;//NUMBER_OF_PHOTONS + THREADS_PER_BLOCK - 1 / THREADS_PER_BLOCK;   
        //cudaMalloc((void **)&NUMBER_OF_PHOTONS, sizeof(int));
        curandState_t *states;
        cudaMalloc((void **)&states, NUMBER_OF_PHOTONS * sizeof(curandState_t));
        // Allocate host memory for final positions
        Photon *_cpuPhotons = (Photon *)malloc(sizeof(Photon) * NUMBER_OF_PHOTONS);
        // Allocate device  memory for final positions
        Photon *_gpuPhotons = nullptr;
        cudaMalloc((void **)&_gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon));
        // Initialize the Boundary and the RandomNumberGenerator
        RNG rng;
        Detector detector = Detector(DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOKAT);
        Tissue tissue = Tissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, TISSUE_ABSORBTION_COEFFICIENT, TISSUE_SCATTERING_COEFFICIENT);
        unsigned int seed = time(0);
        cudaEvent_t start, stop;
        cudaEventCreate(&start);
        cudaEventCreate(&stop);
        // Start recording before the kernel call
        cudaEventRecord(start); 
        // Kernel Call
        //finalPosition<<<nBlocks,THREADS_PER_BLOCK>>>(time(0), states , _gpuPoints, boundary, rng, NUMBER_OF_PHOTONS);
        finalState<<<nBlocks, THREADS_PER_BLOCK>>>(seed, states, _gpuPhotons, detector, rng, tissue, NUMBER_OF_PHOTONS);
        // Stop recording after kernel finishes execution
        cudaEventRecord(stop);
        // Copy device data to host memory to stream them out
        cudaMemcpy(_cpuPhotons, _gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon), cudaMemcpyDeviceToHost);
        // Synchronize before using in calculations
        cudaEventSynchronize(stop);
        // Calculate the total number of operations done by all photons
        for (int i =0; i < NUMBER_OF_PHOTONS; i++){
            std::cout << _cpuPhotons[i].getLifetime() << '\n';
            NUMBER_OF_OPERATIONS += _cpuPhotons[i].getLifetime();
        }
        // Print Bandwidth
        printMetrics(start,stop, nBlocks);
        cudaEventDestroy( start );
        cudaEventDestroy( stop );
        streamOut(&_cpuPhotons[0]);
        free(_cpuPhotons);
        cudaFree(_gpuPhotons);
        cudaFree(states);
        std::cout<< "RandomWalk.o Executed Successfully." << std::endl;
    } else { 
        std::cout<<"Invalid input: Arguments number expected = " <<  25 << ", Recieved = " << argc << std::endl;
        std::cout<<"Initiating Default Walk.."<< std::endl;
        // Running DEFAULT RUN for debugging purposes
        // This part of the code should be erased by the end of developing phase
        // Starts Here
        NUMBER_OF_PHOTONS = 10;
        THREADS_PER_BLOCK = 1024;
        DETECTOR_RADIUS = 10.f;
        DETECTOR_POSITION = Point(0.f, 0.f, 50.f);
        DETECTOR_LOOKAT = Vector(0.f, 0.f, -1.f);
        TISSUE_RADIUS = 100.f;
        TISSUE_ABSORBTION_COEFFICIENT = 1.f;
        TISSUE_SCATTERING_COEFFICIENT = 100.f;
        TISSUE_CENTER_1 = Point(0.f, 0.f, 50.f);
        TISSUE_CENTER_2 = Point(0.f, 0.f, -50.f);
        RNG rng;
        Detector detector = Detector(DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOKAT);
        Tissue tissue = Tissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, TISSUE_ABSORBTION_COEFFICIENT, TISSUE_SCATTERING_COEFFICIENT);
        int nBlocks = NUMBER_OF_PHOTONS / THREADS_PER_BLOCK + 1;//NUMBER_OF_PHOTONS + THREADS_PER_BLOCK - 1 / THREADS_PER_BLOCK;   
        curandState_t *states;
        cudaMalloc((void **)&states, NUMBER_OF_PHOTONS * sizeof(curandState_t));
        // Allocate host memory for final positions
        Photon *_cpuPhotons = (Photon *)malloc(sizeof(Photon) * NUMBER_OF_PHOTONS);
        // Allocate device  memory for final positions
        Photon *_gpuPhotons = nullptr;
        cudaMallocManaged((void **)&_gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon));
        // Register cudaEvents for performance metrics purposes
        cudaEvent_t start, stop;
        cudaEventCreate(&start);
        cudaEventCreate(&stop);
        // Start recording before the kernel call
        cudaEventRecord(start); 
        // Kernel Call
        //finalPosition<<<nBlocks,THREADS_PER_BLOCK>>>(time(0), states , _gpuPoints, boundary, rng, NUMBER_OF_PHOTONS);
        finalState<<<nBlocks, THREADS_PER_BLOCK>>>(time(0), states, _gpuPhotons, detector, rng, tissue, NUMBER_OF_PHOTONS);
        // Stop recording after kernel finishes execution
        cudaEventRecord(stop);
        // Copy device data to host memory to stream them out
        cudaMemcpy(_cpuPhotons, _gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon), cudaMemcpyDeviceToHost);
        // Synchronize before using in calculations
        cudaEventSynchronize(stop);
        // Calculate the total number of operations done by all photons
        for (int i =0; i < NUMBER_OF_PHOTONS; i++){
            NUMBER_OF_OPERATIONS += _cpuPhotons[i].getLifetime();
        }
        // Print Bandwidth
        printMetrics(start,stop, nBlocks);
        cudaEventDestroy( start );
        cudaEventDestroy( stop );
        streamOut(&_gpuPhotons[0]);
        free(_cpuPhotons);
        cudaFree(_cpuPhotons);
        cudaFree(states);
        std::cout<< "Default Run Executed Successfully." << std::endl;

        //Ends Here
    }
    return 0;
}

void streamOut(Photon *_cpuPhotons)
{
    FILE *output;
    output = fopen("output.csv", "w");
    std::string state;
    // Adding Meta-data to the output file
    /*
    *   This Particular order should be maintained if the output was to be read using the Plotter 
    */
     fprintf(output, "X, Y, Z, WEIGHT, STATE,photon_num,%i,threads_per_block,%i,detector_radius,%f,detector_pos,%f,%f,%f,detector_lookAt,%f,%f,%f,tissue_radius,%f,absorp_coeff,%f,scatter_coeff,%f,tissue_center_1,%f,%f,%f,tissue_center_2,%f,%f,%f\n"
    ,NUMBER_OF_PHOTONS, THREADS_PER_BLOCK, DETECTOR_RADIUS, DETECTOR_POSITION.x(), DETECTOR_POSITION.y(), DETECTOR_POSITION.z()
    , DETECTOR_LOOKAT.x(), DETECTOR_LOOKAT.y(), DETECTOR_LOOKAT.z(), TISSUE_RADIUS, TISSUE_ABSORBTION_COEFFICIENT
    , TISSUE_SCATTERING_COEFFICIENT, TISSUE_CENTER_1.x(), TISSUE_CENTER_1.y(), TISSUE_CENTER_1.z(), TISSUE_CENTER_2.x(), TISSUE_CENTER_2.y()
    , TISSUE_CENTER_2.z()); 

    for (int i = 0; i < NUMBER_OF_PHOTONS; i++)
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
    }
} 


bool parseUserInput(int argc, char *argv[], int &nPhotons, int &nThreads, float &dRadius, Point &dPosition, Vector &dLookAt, float &tRadius, float &tAbsorpCoeff,
    float &tScatterCoeff, Point &tCenter1, Point &tCenter2, Point &pPosition, Vector &pLookAt){
        if (argc == 25) {
            nPhotons = std::atoi(argv[1]);
            nThreads = std::atoi(argv[2]);
            dRadius = std::atof(argv[3]);
            dPosition = Point(std::atof(argv[4]), std::atof(argv[5]), std::atof(argv[6]));
            dLookAt = Mathematics::calculateNormalizedVector(Vector(std::atof(argv[7]), std::atof(argv[8]), std::atof(argv[9])));
            tRadius = std::atof(argv[10]);
            tAbsorpCoeff = std::atof(argv[11]);
            tScatterCoeff = std::atof(argv[12]);
            tCenter1 = Point(std::atof(argv[13]), std::atof(argv[14]), std::atof(argv[15]));
            tCenter2 = Point(std::atof(argv[16]), std::atof(argv[17]), std::atof(argv[18]));
            pPosition = Point(std::atof(argv[19]), std::atof(argv[20]), std::atof(argv[21]));
            pLookAt = Mathematics::calculateNormalizedVector(Vector(std::atof(argv[22]), std::atof(argv[23]), std::atof(argv[24])));
            return true;
        } else {
            return false;
        }
    } 

void printMetrics(cudaEvent_t e1, cudaEvent_t e2, int NUMBER_OF_BLOCKS){
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, e1, e2);
    printf("--------------------------------------------------------------------------------------------\n");
    printf("Number of Photons: %i\n", NUMBER_OF_PHOTONS);
    printf("Blocks Used: %i\n", NUMBER_OF_BLOCKS);
    printf("Threads/Block used: %i\n", THREADS_PER_BLOCK);
    printf("Elapsed time (ms): %f\n", milliseconds);
    printf("Total # of operations: %i\n", NUMBER_OF_OPERATIONS);
    printf("Theoretical Bandwidth (GB/s): %f\n", 1122*1e6*(64/8)*2/1e9); // 10e6 becuse core speed is already in MHz
    printf("Effective Bandwidth (GB/s): %f\n", (NUMBER_OF_PHOTONS*sizeof(Photon)*1/1e6)/milliseconds); // 10e6 because time is in milliseconds
    printf("Computational Throughput (GB/s): %f\n", NUMBER_OF_OPERATIONS/ milliseconds/1e6); //Giga-FLoating-point Operations per second, 10e6 because time is in milliseconds
    printf("--------------------------------------------------------------------------------------------\n");
}
