#include "Vector.h"

    Vector::Vector(){
        this->setCoordinates(0.f,0.f,0.f);
    }

    Vector::Vector(Point point)
    {
        this->_x = point.x();
        this->_y = point.y();
        this->_z = point.z();
    }

    Vector::Vector(float x, float y, float z){
        this->_x = x;
        this->_y = y;
        this->_z = z;
    }

    Vector::Vector(Point point1, Point point2)
    {
        this->_x = point2.x() - point1.x();
        this->_y = point2.y() - point1.y();
        this->_z = point2.z() - point1.z();
    }

    __device__ __host__ float Vector::dot(Vector otherVector) { return this->x() * otherVector.x() + this->y() * otherVector.y() + this->z() * otherVector.z(); }

    __device__ __host__ Vector Vector::cross(Vector otherVector)
    {
        float X = this->y() * otherVector.z() - this->z() * otherVector.y();
        float Y = (-1) * this->x() * otherVector.z() + this->z() * otherVector.x();
        float Z = this->x() * otherVector.y() - this->y() * otherVector.x();
        return Point(X, Y, Z);
    }

    __device__ __host__ Vector Vector::normalize()
    {
        float norm = sqrtf((powf(this->x(), 2) + powf(this->y(), 2) + powf(this->z(), 2)));
        float Xhat = this->x() / norm;
        float Yhat = this->y() / norm;
        float Zhat = this->z() / norm;
        return Vector(Xhat,Yhat,Zhat);
    }
