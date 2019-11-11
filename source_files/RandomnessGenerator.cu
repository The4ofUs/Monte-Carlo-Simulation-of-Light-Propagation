#include "RandomnessGenerator.h"
  // Simple random number generator function, generates a float between 0.0 and 1.0
__device__ float RandomnessGenerator::generate( curandState* globalState, int i) 
{
    curandState localState = globalState[i];
    float random = curand_uniform( &localState );
    globalState[i] = localState;
    return random;
}

__device__  float RandomnessGenerator::getRandomStep( curandState* globalState , int i) { 
// Intialize for step value
    float step = 0.f;
    step = generate (globalState, i);
    return step;
 } 

// Returns a Point object that has randomized x,y and z coordinates after converting from randomized spherical coordinates
__device__ Point RandomnessGenerator::getRandomPoint( curandState* globalState , int i)
{
    float u = generate (globalState , i);
    float v = generate (globalState, i);
    
    float theta = 2 * M_PI * u;
    float phi = acos(1 - 2 * v);

    // Transforming into the cartesian space
    float x = sin(phi) * cos(theta);
    float y = sin(phi) * sin(theta);
    float z = cos(phi);

    return Point(x,y,z);
}