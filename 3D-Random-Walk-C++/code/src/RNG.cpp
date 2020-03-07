#include "../headers/RNG.h"

float RNG::generate()
{
    unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);
    std::uniform_real_distribution<float> distribution(0.0, 1.0);
    float random = distribution(generator);
   /* std::ofstream outfile;
    outfile.open("random.csv", std::ios_base::app); // append instead of overwrite
    outfile << random << '\n';*/
    return random;
}


float RNG::getRandomStep()
{
    float step = 0.f; // Intialize for step value
    step = generate();
    return step;
}

Vector RNG::getRandomDirection()
{

    float u = generate();
    float v = generate();
    float theta = 2 * M_PI * u;
    float phi = acos(1 - 2 * v);

    // Transforming into the cartesian space
    float x = sin(phi) * cos(theta);
    float y = sin(phi) * sin(theta);
    float z = cos(phi);

    return Mathematics::calculateNormalizedVector(Vector(x, y, z));
}

Point RNG::getRandomPoint()
{
    float u = generate();
    float v = generate();

    float theta = 2 * M_PI * u;
    float phi = acos(1 - 2 * v);

    // Transforming into the cartesian space
    float x = sin(phi) * cos(theta);
    float y = sin(phi) * sin(theta);
    float z = cos(phi);

    return Point(x, y, z);
}

void RNG::roulette(Photon &photon, float chance)
{
    if (generate() >= chance)
    {
        photon.terminate();
    }
    else
    {
        photon.boost(chance);
    }
}
