#include "RandomWalk.h"
#define N 1000 //number of photons


void streamOut(Point* _cpuPoints);

__global__ void finalPosition(unsigned int seed, curandState_t* states, Point* _gpuPoints, int n) {
    int idx = blockIdx.x*blockDim.x+threadIdx.x;
    if(idx < n){
    curand_init(seed, idx, 0, &states[idx]);
    Point finalPos = Point();
    finalPos = randomWalk(states, idx);
    _gpuPoints[idx] = finalPos;
    }
}

  int main() {

    int threadsPerBlock = 1024;
    int nBlocks = N/threadsPerBlock + 1;
 
    curandState_t* states;
    cudaMalloc((void**) &states, N * sizeof(curandState_t));

// Allocate host memory for final positions
    Point * _cpuPoints= (Point*)malloc(sizeof(Point) * N);

// Allocate device  memory for final positions
    Point* _gpuPoints = nullptr;
    cudaMalloc((void**) &_gpuPoints, N * sizeof(Point));
  
// Call Kernel
    finalPosition<<<nBlocks,threadsPerBlock>>>(time(0), states , _gpuPoints, N);

// Copy device data to host memory to stream them out
    cudaMemcpy(_cpuPoints, _gpuPoints, N* sizeof( Point), cudaMemcpyDeviceToHost);


    streamOut (&_cpuPoints[0]);

    free(_cpuPoints);
    cudaFree(_gpuPoints);

    return 0;

}

void streamOut(Point* _cpuPoints)  
{
    FILE *output;
    output = fopen("output.csv", "w");

    for (int i = 0; i < N; i++)
    {
        // Streaming out my output in a log file
        fprintf(output, "%f,%f,%f\n", _cpuPoints[i].getX(), _cpuPoints[i].getY(), _cpuPoints[i].getZ());
    }
}
