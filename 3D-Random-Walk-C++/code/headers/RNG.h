#ifndef RNG_H
#define RNG_H

#include "~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/headers/Photon.h"
#include "~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/headers/common.h"
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
 * @param states 
 * @param i (int) index for the sake of changing the seed of the RNG
 * @return Random float
 */
   float generate();
    /**
 * @brief Uses generate() to generate a Randomized step
 * 
 * @param states 
 * @param i (int) index for the sake of changing the seed of the RNG
 * @return Random float 
 */
   float getRandomStep();
    /**
 * @brief Uses generate() to get a Randomized direction  **Vector**
 * 
 * @param states 
 * @param i (int) index for the sake of changing the seed of the RNG
 * @return Random **Vector**
 */
   Vector getRandomDirection();

    /**
     * @brief Uses generate() to get a Randomized **Point**
     * 
     * @param states 
     * @param i (int) index for the sake of changing the seed of the RNG
     * @return Random **Point**
     */

   Point getRandomPoint();

    /**
     * @brief The roulette tries a randomly generated float against the *chance* parameter and terminates the **Photon** if the roulette succeeds
     * 
     * @param photon (**Photon**) The target **Photon**
     * @param chance (float) The chance to roulette against
     * @param globalState 
     * @param i (int) index for the sake of changing the seed of the RNG
     */

   void roulette(Photon &photon, float chance);
};
#endif