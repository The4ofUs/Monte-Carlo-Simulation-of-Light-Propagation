#include "RandomWalk.h"
#include "Detector.h"
#include "Vector.h"
#define NUMBER_OF_PHOTONS 100
#define THREADS_PER_BLOCK 1024
#define BOUNDARY_RADIUS 10.0


void streamOut(Point* _cpuPoints);

__global__ void finalPosition(unsigned int seed, curandState_t* states, Point* _gpuPoints, Detector detector, RNG rng, int n) {
    int idx = blockIdx.x*blockDim.x+threadIdx.x;
    if(idx < n){
    curand_init(seed, idx, 0, &states[idx]);
    Point finalPos = Point();
    finalPos = randomWalk(states, idx, detector, rng);
    _gpuPoints[idx] = finalPos;
    }
}

  int main() {
    int nBlocks = NUMBER_OF_PHOTONS/THREADS_PER_BLOCK + 1;
    curandState_t* states;
    cudaMalloc((void**) &states, NUMBER_OF_PHOTONS * sizeof(curandState_t));
    // Allocate host memory for final positions
    Point * _cpuPoints= (Point*)malloc(sizeof(Point) * NUMBER_OF_PHOTONS);
    // Allocate device  memory for final positions
    Point* _gpuPoints = nullptr;
    cudaMalloc((void**) &_gpuPoints, NUMBER_OF_PHOTONS * sizeof(Point));
    // Initialize the Boundary and the RandomNumberGenerator
    RNG rng;
    //Boundary boundary = Boundary(BOUNDARY_RADIUS, Point());
    Detector detector = Detector(10.f,Point(0.f,0.f,5.f), Vector(0.f,0.f,-1.f));
    // Kernel Call
    //finalPosition<<<nBlocks,THREADS_PER_BLOCK>>>(time(0), states , _gpuPoints, boundary, rng, NUMBER_OF_PHOTONS);
    finalPosition<<<nBlocks,THREADS_PER_BLOCK>>>(time(0), states , _gpuPoints, detector, rng, NUMBER_OF_PHOTONS);
    // Copy device data to host memory to stream them out
    cudaMemcpy(_cpuPoints, _gpuPoints, NUMBER_OF_PHOTONS* sizeof(Point), cudaMemcpyDeviceToHost);
    streamOut (&_cpuPoints[0]);
    free(_cpuPoints);
    cudaFree(_gpuPoints);
    return 0;
}

void streamOut(Point* _cpuPoints)  
{
    FILE *output;
    output = fopen("output.csv", "w");
    for (int i = 0; i < NUMBER_OF_PHOTONS; i++)
    {
        // Streaming out my output in a log file
        fprintf(output, "%f,%f,%f\n", _cpuPoints[i].x(), _cpuPoints[i].y(), _cpuPoints[i].z());
    }
}
