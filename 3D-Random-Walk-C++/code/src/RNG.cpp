#include "../headers/RNG.h"

float RNG::generate(unsigned seed)
{ //seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);
    std::uniform_real_distribution<float> distribution(0.0, 1.0);
    float random = distribution(generator);
    return random;
}

float RNG::getRandomStep(unsigned seed)
{
    float step = 0.f; // Intialize for step value
    step = generate(seed);
    return step;
}

Vector RNG::getRandomDirection(unsigned seed)
{
    float u = generate(seed);
    float v = generate(seed);
    float theta = 2 * M_PI * u;
    float phi = acos(1 - 2 * v);

    // Transforming into the cartesian space
    float x = sin(phi) * cos(theta);
    float y = sin(phi) * sin(theta);
    float z = cos(phi);

    return Mathematics::calculateNormalizedVector(Vector(x, y, z));
}

Point RNG::getRandomPoint(unsigned seed)
{
    float u = generate(seed);
    float v = generate(seed);

    float theta = 2 * M_PI * u;
    float phi = acos(1 - 2 * v);

    // Transforming into the cartesian space
    float x = sin(phi) * cos(theta);
    float y = sin(phi) * sin(theta);
    float z = cos(phi);

    return Point(x, y, z);
}

void RNG::roulette(Photon &photon, float chance, unsigned seed)
{
    if (generate(seed) >= chance)
    {
        photon.terminate();
    }
    else
    {
        photon.boost(chance);
    }
}
