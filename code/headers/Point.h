#ifndef POINT_H
#define POINT_H

/**
 * A point in the space defined by the cartesian coordinates (X, Y, Z)
 */
class Point
{

public:
    /**
     * @brief Constructor
     */
    __device__ __host__
    Point(float x, float y, float z);

    /**
     * @brief Constructor
     */
    __device__ __host__
    Point();

    /**
     * @brief setCoordinates
     * Updates the coordinates of the point to the given ones.
     * @param x (float)
     * @param y (float)
     * @param z (float)
     */
    __device__ __host__ void setCoordinates(float x, float y, float z);

    /**
     * @return The X coordinate of the point.
     */
    __device__ __host__ float x() const;

    /**
     * @return The Y coordinate of the point.
     */
    __device__ __host__ float y() const;

    /**
     * @return The Z coordinate of the point.
     */
    __device__ __host__ float z() const;

    /**
     * Overloading the + operator
     */
    __device__ __host__
        Point
        operator+(Point const &other);

    /**
     * Overloading the - operator
     */
    __device__ __host__
        Point
        operator-(Point const &other);

    /**
     * Overloading the * operator
     */
    __device__ __host__
        Point
        operator*(float const &other);

protected:
    /**
     * The X coordinate of the point.
     */
    float _x;

    /**
     * The Y coordinate of the point.
     */
    float _y;

    /**
     * The Z coordinate of the point.
     */
    float _z;
};

#endif