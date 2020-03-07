#include "code/headers/randomwalk.h"
#include <sstream>

//#define NUMBER_OF_PHOTONS 1000
#define THREADS_PER_BLOCK 1024
#define DETECTOR_RADIUS 10.f
#define DETECTOR_POSITION Point(0.f, 0.f, 50.f)
#define DETECTOR_LOOKAT Vector(0.f, 0.f, -1.f)
#define TISSUE_RADIUS 1000.f
//#define TISSUE_ABSORBTION_COEFFICIENT 1.f
#define TISSUE_SCATTERING_COEFFICIENT 100.f
#define TISSUE_CENTER_1 Point(0.f, 0.f, 50.f)
#define TISSUE_CENTER_2 Point(0.f, 0.f, -50.f)

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

void streamOut(int a, float c, float d, unsigned long long e, unsigned long long f, float g, float h, float i, int j, int k)
{
    FILE *output;
    output = fopen("metrics.csv", "a");
    if (output != NULL){
        fprintf(output, "%i, %f, %f, %llu, %llu, %f, %f, %f, %i, %i\n", a, c, d, e, f, g, h, i ,j ,k);
        fclose(output);
    } else {
        std::cout<<"Failed to open file, retrying!" << std::endl;
        streamOut(a,c,d,e,f,g,h,i,j,k);
    }
}

void run(int n, float Ma){
    int NUMBER_OF_PHOTONS = n;
    float TISSUE_ABSORBTION_COEFFICIENT  = Ma;
    unsigned int NUMBER_OF_TEST_RUNS = 100;
    float totalTime = 0.f;
    unsigned long long totalLifetime = 0;
    float detected = 0.f;
    float terminated = 0.f;
    float escaped = 0.f;
    int nBlocks = NUMBER_OF_PHOTONS + THREADS_PER_BLOCK - 1 / THREADS_PER_BLOCK;
    for (int i= 0; i<NUMBER_OF_TEST_RUNS; i++){
        RNG rng;
        Detector detector = Detector(DETECTOR_RADIUS, DETECTOR_POSITION, DETECTOR_LOOKAT);
        Tissue tissue = Tissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, TISSUE_ABSORBTION_COEFFICIENT, TISSUE_SCATTERING_COEFFICIENT);
        curandState_t *states;
        cudaMalloc((void **)&states, NUMBER_OF_PHOTONS * sizeof(curandState_t));
        Photon *_cpuPhotons = (Photon *)malloc(sizeof(Photon) * NUMBER_OF_PHOTONS);
        Photon *_gpuPhotons = nullptr;
        cudaMalloc((void **)&_gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon));
        unsigned int seed = time(0);
        cudaEvent_t start, stop;
        cudaEventCreate(&start);
        cudaEventCreate(&stop);
        cudaEventRecord(start); 
        finalState<<<nBlocks, THREADS_PER_BLOCK>>>(seed, states, _gpuPhotons, detector, rng, tissue, NUMBER_OF_PHOTONS);
        cudaEventRecord(stop);
        cudaMemcpy(_cpuPhotons, _gpuPhotons, NUMBER_OF_PHOTONS * sizeof(Photon), cudaMemcpyDeviceToHost);
        cudaEventSynchronize(stop);
        float milliseconds = 0;
        cudaEventElapsedTime(&milliseconds, start, stop);
        totalTime += milliseconds;
        cudaEventDestroy( start );
        cudaEventDestroy( stop );
        for (int j=0; j<NUMBER_OF_PHOTONS; j++){
            totalLifetime += _cpuPhotons[j].getLifetime();
            if ( _cpuPhotons[j].getState() == Photon::DETECTED){
                detected += 1;
            } else if ( _cpuPhotons[j].getState() == Photon::TERMINATED){
                terminated += 1;
            } else {
                escaped += 1 ;
            }
        }
        free(_cpuPhotons);
        cudaFree(_gpuPhotons);
        cudaFree(states);
        }
    /*std::cout << "# Photons = " << NUMBER_OF_PHOTONS << std::endl;
    std::cout << "Attenuation Coefficient = " << TISSUE_ABSORBTION_COEFFICIENT + TISSUE_SCATTERING_COEFFICIENT << std::endl;
    std::cout << "Average Time = " << totalTime/NUMBER_OF_TEST_RUNS << " ms" << std::endl;
    std::cout << "Average Total # of Walks = " << totalLifetime/NUMBER_OF_TEST_RUNS << " walks" << std::endl;
    std::cout << "Average Detected/Total = " << (detectedRatio/NUMBER_OF_TEST_RUNS)/NUMBER_OF_PHOTONS << std::endl;
    std::cout << "Average Terminated/Total = " << (terminatedRatio/NUMBER_OF_TEST_RUNS)/NUMBER_OF_PHOTONS << std::endl;
    std::cout << "Average Escaped/Total = " << (escapedRatio/NUMBER_OF_TEST_RUNS)/NUMBER_OF_PHOTONS << std::endl;
    std::cout << "#Threads/Block = " << THREADS_PER_BLOCK << std::endl;
    std::cout << "# Blocks = " << NUMBER_OF_PHOTONS / THREADS_PER_BLOCK + 1 << std::endl; */
    float detectedRatio = ((detected/NUMBER_OF_TEST_RUNS)/NUMBER_OF_PHOTONS);
    float terminatedRatio = ((terminated/NUMBER_OF_TEST_RUNS)/NUMBER_OF_PHOTONS);
    float escapedRatio = ((escaped/NUMBER_OF_TEST_RUNS)/NUMBER_OF_PHOTONS);
    streamOut(NUMBER_OF_PHOTONS, (TISSUE_ABSORBTION_COEFFICIENT + TISSUE_SCATTERING_COEFFICIENT), (totalTime/NUMBER_OF_TEST_RUNS), (totalLifetime/NUMBER_OF_TEST_RUNS), (totalLifetime/NUMBER_OF_TEST_RUNS)/NUMBER_OF_PHOTONS, detectedRatio, terminatedRatio, escapedRatio, THREADS_PER_BLOCK, (NUMBER_OF_PHOTONS / THREADS_PER_BLOCK + 1));
}

int main(){
    int number[] = {1,10,100,1000,10000};
    float coefficients[] = {100,1000,10000};
    for(int i = 0; i<(sizeof(number)/sizeof(int)); i++){
        for(int j= 0; j<(sizeof(coefficients)/sizeof(float)); j++){
            run(number[i],coefficients[j]);
            std::cout<<"( "<< number[i] << ", " << coefficients[j] << ")    Done!" << std::endl;
        }
    }
    printf("--------------------------------------\n--------------------------------------\n--------------------------------------\n--------------------------------------\n");
    return 0;
}




