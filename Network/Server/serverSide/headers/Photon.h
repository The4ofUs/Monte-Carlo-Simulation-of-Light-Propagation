#ifndef PHOTON_H
#define PHOTON_H

#include "Point.h"

/**
 * @brief Represents the object that's going to random walk through the **Tissue**
 *
 */
class Photon
{
public:

    Photon();
    /*
     * @brief Constructor
     * Initiates a **Photon** at a certain **Point** in the 3D Space
     *
     * @param position (**Point**)
     */
    Photon(Point position);

    /*
    * @param weight (float)
    */
    void setWeight(double weight);
    /*
     * @param point (**Point**)
     */
    void setPosition(Point point);
    /*
     * @see Photon::ROAMING, Photon::DETECTED, Photon::TERMINATED and Photon::ESCAPED
     *
     * @param state (int)
     */
    void setState(long state);
    /*
     * @return **Photon**'s current weight
     */
    double getWeight();
    /*
     * @return **Photon**'s current position
     */
    Point getPosition();
    /*
     * @return **Photon**'s current state
     */
    long getState();

    /*
     * @brief Terminates the Photon instantly i.e. sets its weight = 0
     *
     * There are certain occasions the functions is used at:
     * - RNG::roulette()
     * - Tissue::escaped()
     */
    void terminate();

    /*
     * @brief Boosts the **Photon** with an incrementation in its weight
     *
     * Occurs only if the RNG::roulette() failed in terminating the **Photon**
     *
     * @param factor (float) this factor is the same factor the **RNG** uses to roulette the **Photon**
     */


    /*
 * @brief Photon::ROAMING means the **Photon** is still Random walking
 */
    static const long ROAMING = 0;
    /*
     * @brief Photon::TERMINATED means that the **Photon** got terminated by the RNG::roulette()
     */
    static const long TERMINATED = -1;
    /*
     * @brief Photon::DETECTED means that the **Photon** did hit the **Detector**'s screen
     */
    static const long DETECTED = 1;
    /*
     * @brief Photon::ESCAPED means that the **Photon** did escape from the Tissue
     *
     */
    static const long ESCAPED = 2;

private:
    /*
 * @brief Current weight of the **Photon**
 */
    double _weight;
    /*
     * @brief Current position of the **Photon**
     *
     */
    Point _position;
    /*
     * @brief Current state of the **Photon**
     *
     */
    long _state;
};

#endif
