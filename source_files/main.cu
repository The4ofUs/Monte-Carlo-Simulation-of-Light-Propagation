#include "RandomWalk.h"
#define N 1000 // Number of photons 


void streamOut(float* _cpuX, float* _cpuY , float* _cpuZ);
/*
__global__ void finalPosition(unsigned int seed, curandState_t* states, float* _gpuX, float* _gpuY, float* _gpuZ) {
    curand_init(seed, blockIdx.x, 0, &states[blockIdx.x]);

    Point finalPos; //should pass states here as an arg
    finalPos = randomWalk(states);
    _gpuX[blockIdx.x] = finalPos.getX();
    _gpuY[blockIdx.x] = finalPos.getY();
    _gpuZ[blockIdx.x] = finalPos.getZ();

}
*/

__global__ void finalPosition(unsigned int seed, curandState_t* states, Point* _gpuPoints) {
    curand_init(seed, blockIdx.x, 0, &states[blockIdx.x]);
    Point finalPos; //should pass states here as an arg
    finalPos = randomWalk(states);
    _gpuPoints[blockIdx.x] = finalPos;
}

  int main() {
    curandState_t* states;
    cudaMalloc((void**) &states, N * sizeof(curandState_t));

// Allocate host memory for final positions
/*
    float * _cpuX= (float*)malloc(sizeof(float) * N);
    float * _cpuY= (float*)malloc(sizeof(float) * N);
    float * _cpuZ= (float*)malloc(sizeof(float) * N);
*/
    Point * _cpuPoints= (Point*)malloc(sizeof(Point) * N);

// Allocate device  memory for final positions
/*    
    float* _gpuX = nullptr;
    cudaMalloc((void**) &_gpuX, N * sizeof(float));
    float* _gpuY = nullptr;
    cudaMalloc((void**) &_gpuY, N * sizeof(float));
    float* _gpuZ = nullptr;
    cudaMalloc((void**) &_gpuZ, N * sizeof(float));
*/
    Point* _gpuPoints = nullptr;
    cudaMalloc((void**) &_gpuPoints, N * sizeof(Point));
  
// Call Kernel
/*
    finalPosition<<<N , 1>>>(time(0), states , _gpuX, _gpuY, _gpuZ);
*/
    finalPosition<<<N , 1>>>(time(0), states , _gpuPoints);

// Copy device data to host memory to stream them out
/*
    cudaMemcpy(_cpuX, _gpuX, N * sizeof( float), cudaMemcpyDeviceToHost);
    cudaMemcpy(_cpuY, _gpuY, N * sizeof( float), cudaMemcpyDeviceToHost);
    cudaMemcpy(_cpuZ, _gpuZ, N * sizeof( float), cudaMemcpyDeviceToHost);
*/
    cudaMemcpy(_cpuPoints, _gpuPoints, N* sizeof( Point), cudaMemcpyDeviceToHost);

    // Stream out final position of each photon to file
/*
    streamOut (&_cpuX[0], &_cpuY[0], &_cpuZ[0]);
*/
    streamOut (&_cpuPoints);

// Free Memory
/*
    free(_cpuX);
    free(_cpuY);
    free(_cpuZ);
    cudaFree(_gpuX);
    cudaFree(_gpuY);
    cudaFree(_gpuZ);
*/
    free(_cpuPoints);
    cudaFree(_gpuPoints);

    return 0;

}

/*
void streamOut(float* _cpuX, float* _cpuY , float* _cpuZ)  
{
    FILE *output;
    output = fopen("output.csv", "a");

    for (int i = 0; i < N; i++)
    {
        // Streaming out my output in a log file
        fprintf(output, "%f,%f,%f\n", _cpuX[i], _cpuY[i], _cpuZ[i]);
    }
}
*/
void streamOut(Point* _cpuPoints)  
{
    FILE *output;
    output = fopen("output.csv", "a");

    for (int i = 0; i < N; i++)
    {
        // Streaming out my output in a log file
        fprintf(output, "%f,%f,%f\n", _cpuPoints[i].getX(), _cpuPoints[i].getY(), _cpuPoints[i].getZ());
    }
}
