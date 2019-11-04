#include "RandomWalk.h"
#define N 1000 // Number of photons 


void streamOut(float* _cpuX, float* _cpuY , float* _cpuZ);

__global__ void finalPosition(unsigned int seed, curandState_t* states, float* _gpuX, float* _gpuY, float* _gpuZ) {
    curand_init(seed, blockIdx.x, 0, &states[blockIdx.x]);

    Point finalPos; //should pass states here as an arg
    finalPos = randomWalk(states);
    _gpuX[blockIdx.x] = finalPos.getX();
    _gpuY[blockIdx.x] = finalPos.getY();
    _gpuZ[blockIdx.x] = finalPos.getZ();

}


  int main() {
    curandState_t* states;
    cudaMalloc((void**) &states, N * sizeof(curandState_t));

// Allocate host memory for final positions
    float * _cpuX= (float*)malloc(sizeof(float) * N);
    float * _cpuY= (float*)malloc(sizeof(float) * N);
    float * _cpuZ= (float*)malloc(sizeof(float) * N);

// Allocate device  memory for final positions
    float* _gpuX = nullptr;
    cudaMalloc((void**) &_gpuX, N * sizeof(float));
    float* _gpuY = nullptr;
    cudaMalloc((void**) &_gpuY, N * sizeof(float));
    float* _gpuZ = nullptr;
    cudaMalloc((void**) &_gpuZ, N * sizeof(float));
  
// Call Kernel
    finalPosition<<<N , 1>>>(time(0), states , _gpuX, _gpuY, _gpuZ);

// Copy device data to host memory to stream them out
    cudaMemcpy(_cpuX, _gpuX, N * sizeof( float), cudaMemcpyDeviceToHost);
    cudaMemcpy(_cpuY, _gpuY, N * sizeof( float), cudaMemcpyDeviceToHost);
    cudaMemcpy(_cpuZ, _gpuZ, N * sizeof( float), cudaMemcpyDeviceToHost);

    // Stream out final position of each photon to file
    streamOut (&_cpuX[0], &_cpuY[0], &_cpuZ[0]);

// Free Memory
    free(_cpuX);
    free(_cpuY);
    free(_cpuZ);
    cudaFree(_gpuX);
    cudaFree(_gpuY);
    cudaFree(_gpuZ);

    return 0;

}
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
