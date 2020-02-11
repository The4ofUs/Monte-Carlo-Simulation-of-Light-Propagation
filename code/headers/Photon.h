#ifndef PHOTON_H
#define PHOTON_H

#include "Ray.h"

/**
 * @brief Represents the object that's going to random walk through the **Tissue**
 * 
 */
class Photon
{
public:
   /**
 * @brief Constructor
 * 
 */
   __device__ Photon();
   /**
     * @brief Constructor
     * Initiates a **Photon** at a certain **Point** in the 3D Space
     * 
     * @param position (**Point**)
     */
   __device__ Photon(Point position);

   /**
 * @param weight (float)
 */
   __device__ void setWeight(float weight);
   /**
     * @param point (**Point**)
     */
   __device__ void setPosition(Point point);
   /**
     * @see Photon::ROAMING, Photon::DETECTED, Photon::TERMINATED and Photon::ESCAPED
     * 
     * @param state (int)
     */
   __device__ void setState(short state);
   /**
     * @return **Photon**'s current weight
     */
   __device__ __host__ float getWeight();
   /**
     * @return **Photon**'s current position
     */
   __device__ __host__ Point getPosition();
   /**
     * @return **Photon**'s current state
     */
   __device__ __host__ short getState();

   /**
     * @brief Terminates the Photon instantly i.e. sets its weight = 0
     * 
     * There are certain occasions the functions is used at:
     * - RNG::roulette()
     * - Tissue::escaped()
     */
   __device__ void terminate();

   /**
     * @brief Boosts the **Photon** with an incrementation in its weight
     * 
     * Occurs only if the RNG::roulette() failed in terminating the **Photon**
     * 
     * @param factor (float) this factor is the same factor the **RNG** uses to roulette the **Photon**
     */
   __device__ void boost(float factor);

   /**
 * @brief Moves the **Photon** along the given path
 * 
 * @param path (**Ray**)
 */
   __device__ void moveAlong(Ray path);

   /**
 * @brief Photon::ROAMING means the **Photon** is still Random walking
 */
   static const short ROAMING = 0;
   /**
     * @brief Photon::TERMINATED means that the **Photon** got terminated by the RNG::roulette()
     */
   static const short TERMINATED = -1;
   /**
     * @brief Photon::DETECTED means that the **Photon** did hit the **Detector**'s screen
     */
   static const short DETECTED = 1;
   /**
     * @brief Photon::ESCAPED means that the **Photon** did escape from the Tissue
     * 
     */
   static const short ESCAPED = 2;

private:
   /**
 * @brief Current weight of the **Photon**
 */
   float _weight;
   /**
     * @brief Current position of the **Photon**
     * 
     */
   Point _position;
   /**
     * @brief Current state of the **Photon**
     * 
     */
   short _state;
};

#endif