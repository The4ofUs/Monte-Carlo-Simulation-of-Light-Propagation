#include "RandomnessGenerator.h"

__global__ void randomPoint( unsigned int seed, float* gpu_random_parameters, curandState_t* states){
    // initialize the random states
 curand_init(seed, //must be different every run so the sequence of numbers change
    blockIdx.x, // the sequence number should be different for each core 
    0, //step between random numbers
    &states[blockIdx.x]);
    gpu_random_parameters[blockIdx.x]=curand_uniform(&states[blockIdx.x]);
  }
  
  // Simple random number generator function, generates a float between 0.0 and 1.0
  float RandomnessGenerator::getRandomStep() const { 
//Define number of parameters to be randomly generated
    const int N = 1;

// Intialize for step value
    float step = 0.f;

// Generates array of different states
    curandState_t* states;
    cudaMalloc((void**) &states, N * sizeof(curandState_t)); 

// Allocating gpu array for step generated value in kernel
    float* gpu_random_step = nullptr;
    cudaMalloc((void**) &gpu_random_step,  N * sizeof(float)); 

// Calls kernel to generate random step
    randomPoint<<<N, 1>>>(time(nullptr),gpu_random_step, states);

// Copy GPU parameters into Host parameters to be able to pass it to host functions
    cudaMemcpy(&step, gpu_random_step, N * sizeof(float), cudaMemcpyDeviceToHost);

    return step;
 } 

// Returns a Point object that has randomized x,y and z coordinates after converting from randomized spherical coordinates
 Point RandomnessGenerator::getRandomPoint()
{
    Point point; // Instance of the Point struct to return with the random coordinates
// Define number of parameters to be randomly generated
    const int N = 2;

// Generates array of different states
    curandState_t* states;
    cudaMalloc((void**) &states, N * sizeof(curandState_t)); 

// Allocating gpu array for u,v,r generated value in kernel
    float* gpu_random_parameters = nullptr;
    cudaMalloc((void**) &gpu_random_parameters,  N* sizeof(float)); 

// Allocate CPU array to copy the elements of the GPU array in it to be able to stream thhem out.
    float* cpu_random_parameters = (float*)malloc(sizeof(float) * N);

// Getting random values for spherical coordinates transformation parameters
    randomPoint<<<N, 1>>>(time(nullptr),gpu_random_parameters, states);

// Copy GPU parameters into Host parameters to be able to pass it to host functions  
    cudaMemcpy(cpu_random_parameters, gpu_random_parameters, N*sizeof(float), cudaMemcpyDeviceToHost);

    float u = cpu_random_parameters[0] ;
    float v = cpu_random_parameters[1];
    
    float theta = 2 * M_PI * u;
    float phi = acos(1 - 2 * v);

    // Transforming into the cartesian space
    float x = sin(phi) * cos(theta);
    float y = sin(phi) * sin(theta);
    float z = cos(phi);

    point.setCoordinates(x, y, z);
  


    exportSamplingPlot(point);

    return point;

}

// A helper function to generate a csv file to use in plotting
void RandomnessGenerator::exportSamplingPlot(Point point)
{
    // For streaming out my output in a log file
    FILE *sampling;
    sampling = fopen("sampling.csv", "a");
    // Streaming out my output in a log file
    fprintf(sampling, "%f,%f,%f\n", point.getX(), point.getY(), point.getZ());
} 

