#include "/home/gamila/Documents/GP/Task4-RandomWalkCUDA/3D-Random-Walk-CUDA/include/header.h"
#define NUMBER_OF_ITERATIONS 500 // Number of steps, just for the demo, this number should be decided or taken later on by the user

int main()
{
    // Creating an instance of our RandomnessGenerator class
    RandomnessGenerator randomnessGenerator;
    Ray ray;
    Point origin;
    origin.setCoordinates(0.f, 0.f, 0.f);
    ray.startFrom(origin);

    // For streaming out my output in a log file
    FILE *output;
    output = fopen("output.csv", "a");

    for (int i = 0; i < NUMBER_OF_ITERATIONS; i++)
    {

        // Setting ray direction
        ray.setDirection(randomnessGenerator.getRandomPoint());

        // Setting ray step
        ray.setStep(randomnessGenerator.getRandomStep());

        // Move!
        ray.move();

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

    return 0;
}