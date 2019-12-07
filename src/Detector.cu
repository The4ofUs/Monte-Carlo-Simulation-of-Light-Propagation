#include "Detector.h"
#include "Point.h"

__device__ __host__ Detector::Detector(float radius, Point center, Vector normal){
    this->_radius = radius;
    this->_center = center;
    this->_normal = normal;
};

