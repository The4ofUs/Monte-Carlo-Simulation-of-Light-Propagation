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
  float generate();
  /**
 * @brief Uses generate() to generate a Randomized step
 * 
 * @return Random float 
 */
  float getRandomStep();
  /**
 * @brief Uses generate() to get a Randomized direction  **Vector**
 * 
 * @return Random **Vector**
 */
  Vector getRandomDirection();

  /**
     * @brief Uses generate() to get a Randomized **Point**
     * 
     * @return Random **Point**
     */

  Point getRandomPoint();

  /**
     * @brief The roulette tries a randomly generated float against the *chance* parameter and terminates the **Photon** if the roulette succeeds
     * 
     * @param photon (**Photon**) The target **Photon**
     * @param chance (float) The chance to roulette against
     */

  void roulette(Photon &photon, float chance);
};
#endif