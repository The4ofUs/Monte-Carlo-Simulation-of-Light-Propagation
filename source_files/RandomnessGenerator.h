#ifndef Randomness_H
#define Randomness_H

#include <curand.h>
#include <curand_kernel.h>
#include "Point.h"

class RandomnessGenerator
{  
    // Access specifier followed by the Data members then function members
public:

__device__ float generate( curandState* states );
    // Function that returns a random step
__device__ float getRandomStep( curandState* states );
    // Returns a random triplet of floats (x,y,z) as an instance of Point
__device__ Point getRandomPoint( curandState* states );
};
#endif 