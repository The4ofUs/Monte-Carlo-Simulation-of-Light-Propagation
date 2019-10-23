#ifndef Randomness_H
#define Randomness_H

#include <curand.h>
#include <curand_kernel.h>
#include "Point.h"

class RandomnessGenerator
{  
    // Access specifier followed by the Data members then function members
public:
    // Function that returns a random step
    float getRandomStep() const;
    // Returns a random triplet of floats (x,y,z) as an instance of Point
    Point getRandomPoint();
    void exportSamplingPlot(Point point);
};
#endif 