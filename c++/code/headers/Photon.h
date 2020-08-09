#ifndef PHOTON_H
#define PHOTON_H

#include "Ray.h"

class Photon
{
public:
  Photon();

  Photon(Point position);

  void setWeight(float weight);

  void setPosition(Point point);

  void setState(short state);

  float getWeight();

  Point getPosition();

  short getState();

  void terminate();

  void boost(float factor);

  void moveAlong(Ray path);

  static const short ROAMING = 0;

  static const short TERMINATED = -1;

  static const short DETECTED = 1;

  static const short ESCAPED = 2;

private:
  float _weight;

  Point _position;

  short _state;
};

#endif