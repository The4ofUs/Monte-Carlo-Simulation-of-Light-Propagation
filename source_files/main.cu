#include "header.h"
#define N 1000 // Number of photons 

__global__ void setupKernel(unsigned int seed, curandState_t* states){

    curand_init(seed, //must be different every run so the sequence of numbers change. 
        blockIdx.x, // the sequence number should be different for each core ???
        0, //step between random numbers
        &states[blockIdx.x]);
      
}

__global__ void finalPosition(curandState_t* states, float* _gpuX, float* _gpuY, float* _gpuZ) {
    
    uniform_random_numbers[blockIdx.x] = curand_uniform(&states[blockIdx.x]);
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
    setupKernel<<<N , 1>>> (time(0), states;)
    finalPosition<<<N , 1>>>(states , _gpuX, _gpuY, _gpuZ);

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

    for (int i = 0; i < NUMBER_OF_ITERATIONS; i++)
    {
        //Checking output
        std::cout << "Movement #" << i << ":\n"
                  << "Current Position: "
                  << "( " << ray.getCurrentPos().getX() << ", "
                  << ray.getCurrentPos().getY() << ", " << ray.getCurrentPos().getZ() << " )\n"
                  << "Direction : "
                  << "( "
                  << ray.getDirection().getX() << ", " << ray.getDirection().getY() << ", " << ray.getDirection().getZ()
                  << " )\n"
                  << "Step: " << ray.getStep() << "\n"
                  << std::endl;

        // Streaming out my output in a log file
        fprintf(output, "%f,%f,%f\n", ray.getCurrentPos().getX(), ray.getCurrentPos().getY(), ray.getCurrentPos().getZ());
    }
}
