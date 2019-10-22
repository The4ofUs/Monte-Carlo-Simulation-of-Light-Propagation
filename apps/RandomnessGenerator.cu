#include "/home/gamila/Documents/GP/Task4-RandomWalkCUDA/3D-Random-Walk-CUDA/include/RandomnessGenerator.h"
using namespace std;


__global__ void randomPoint( unsigned int seed, float* randomParameters, curandState_t* states){
    // initialize the random states
 curand_init(seed, //must be different every run so the sequence of numbers change. 
    blockIdx.x, // the sequence number should be different for each core ???
    0, //step between random numbers
    &states[blockIdx.x]);
    randomParameters[blockIdx.x]=curand_uniform(&states[blockIdx.x]);
  }
  
  // Simple random number generator function, generates a float between 0.0 and 1.0
  float RandomnessGenerator::getRandomStep() const { 
    const int N=1;
    float step=0.f;
    float* randomParameters_step= nullptr;
    cudaMalloc((void**) &randomParameters_step,  N* sizeof(float)); 
    curandState_t* states;
    cudaMalloc((void**) &states, N * sizeof(curandState_t));

    randomPoint<<<N, 1>>>(time(0),randomParameters_step, states);
    cudaMemcpy(&step, randomParameters_step, N*sizeof(float), cudaMemcpyDeviceToHost);
    return step;
 } 

// Returns a Point object that has randomized x,y and z coordinates after converting from randomized spherical coordinates
float RandomnessGenerator::getRandomPoint()
{
    Point point; // Instance of the Point struct to return with the random coordinates

    int N=3;
    float* randomParameters= nullptr;
    cudaMalloc((void**) &randomParameters,  N* sizeof(float)); 
    curandState_t* states;
    cudaMalloc((void**) &states, N * sizeof(curandState_t)); 

    float* cpu_randoms= (float*)malloc(sizeof(float) * N);
    // Getting random values for spherical coordinates transformation parameters
    randomPoint<<<N, 1>>>(time(0),randomParameters, states);
    
    cudaMemcpy(cpu_randoms, randomParameters, N*sizeof(float), cudaMemcpyDeviceToHost);
    float u=cpu_randoms[0] ;
    float v= cpu_randoms[1];
    //float r= cpu_randoms[2];
    
    float theta = 2 * M_PI * u;
    float phi = acos(1 - 2 * v);

    // Transforming into the cartesian space
    float x = sin(phi) * cos(theta);
    float y = sin(phi) * sin(theta);
    float z = cos(phi);

    point.setCoordinates(x, y, z);
  


   exportSamplingPlot(point);

    return x;

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

int main() {
RandomnessGenerator randomnessGenerator;
float x= randomnessGenerator.getRandomPoint();
float step =randomnessGenerator.getRandomStep();

  
std:: cout << x <<endl;
std:: cout <<step <<endl;


  /* free the memory we allocated */
 //cudaFree(u_randoms); 
  return 0;
    
}