#ifndef MATHEMATICS_H
#define MATHEMATICS_H
#include "Vector.h"
#include "common.h"
namespace Mathematics
{

float calculateAbsDistance(Point p1, Point p2);

float calculateAbsDistance(Point p);

float calculateDotProduct(Vector v1, Vector v2);

Vector calculateCrossProduct(Vector v1, Vector v2);

Vector calculateNormalizedVector(Vector v);

// Needs to be tested
Point calculateRayTip(Point origin, Vector direction, float step);
} // namespace Mathematics
#endif
