#include "RandomWalk.h"
#define N 5000 //number of photons


void streamOut(Point* _cpuPoints);

__global__ void finalPosition(unsigned int seed, curandState_t* states, Point* _gpuPoints) {
    curand_init(seed, blockIdx.x, 0, &states[blockIdx.x]);
    Point finalPos = Point();
    finalPos = randomWalk(states);
    _gpuPoints[blockIdx.x] = finalPos;
}

  int main() {
    curandState_t* states;
    cudaMalloc((void**) &states, N * sizeof(curandState_t));

// Allocate host memory for final positions
    Point * _cpuPoints= (Point*)malloc(sizeof(Point) * N);

// Allocate device  memory for final positions
    Point* _gpuPoints = nullptr;
    cudaMalloc((void**) &_gpuPoints, N * sizeof(Point));
  
// Call Kernel
    finalPosition<<<N,1>>>(time(0), states , _gpuPoints);

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
