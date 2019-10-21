#include "/home/gamila/Documents/GP/Task4-RandomWalkCUDA/3D-Random-Walk-CUDA/include/RandomnessGenerator.h"

// Simple random number generator function, generates a float between 0.0 and 1.0
float RandomnessGenerator::getRandomStep() const { return {((float)rand()) / (float)RAND_MAX}; }

// Returns a Point object that has randomized x,y and z coordinates after converting from randomized spherical coordinates
Point RandomnessGenerator::getRandomPoint()
{
    Point point; // Instance of the Point struct to return with the random coordinates

    // Getting random values for spherical coordinates transformation parameters
    float u = static_cast<float>(((float)rand()) / (float)RAND_MAX);
    float v = static_cast<float>(((float)rand()) / (float)RAND_MAX);
    float r = static_cast<float>(cbrt(((float)rand()) / (float)RAND_MAX)); // Cubic root to prevent clumping in the center

    // Transformation equations
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