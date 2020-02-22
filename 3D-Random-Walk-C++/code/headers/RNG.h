#ifndef RNG_H
#define RNG_H

#include "Photon.h"
#include "common.h"
#include <chrono>
#include <random> //To use unifrom distributed random number generation function
/**
 * @brief The RNG class
 * 
 * 
 * Pseudo Random Number Generator
 * Where the magic happens
 */
class RNG
{
public:
  /**
 * @brief Generates the random floats for the rest of the working parts
 * 
 * @return Random float
 */
  float generate(unsigned seed);
  /**
 * @brief Uses generate() to generate a Randomized step
 * 
 * @return Random float 
 */
  float getRandomStep(unsigned seed);
  /**
 * @brief Uses generate() to get a Randomized direction  **Vector**
 * 
 * @return Random **Vector**
 */
  Vector getRandomDirection(unsigned seed);

  /**
     * @brief Uses generate() to get a Randomized **Point**
     * 
     * @return Random **Point**
     */

  Point getRandomPoint(unsigned seed);

  /**
     * @brief The roulette tries a randomly generated float against the *chance* parameter and terminates the **Photon** if the roulette succeeds
     * 
     * @param photon (**Photon**) The target **Photon**
     * @param chance (float) The chance to roulette against
     */

  void roulette(Photon &photon, float chance, unsigned seed);
};
#endif