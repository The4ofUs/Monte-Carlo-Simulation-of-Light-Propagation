#ifndef POINT_H
#define POINT_H

/**
 * @brief The Point class
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
     * @param x
     * @param y
     * @param z
     */
    __device__ __host__ void setCoordinates(float x, float y, float z);

    /**
     * @brief getX
     * @return
     * The X coordinate of the point.
     */
    __device__ __host__ float x() const;

    /**
     * @brief getY
     * @return
     * The Y coordinate of the point.
     */
    __device__ __host__ float y() const;

    /**
     * @brief getZ
     * @return
     * The Z coordinate of the point.
     */
    __device__ __host__ float z() const;

    /**
     * @brief operator +
     * Overloading the + operator
     */
    __device__ __host__
        Point
        operator+(Point const &other);

    /**
     * @brief operator -
     * Overloading the - operator
     */
    __device__ __host__
        Point
        operator-(Point const &other);

    /**
     * @brief operator *
     * Overloading the * operator
     */
    __device__ __host__
        Point
        operator*(float const &other);

protected:
    /**
     * @brief _x
     * The X coordinate of the point.
     */
    float _x;

    /**
     * @brief _y
     * The Y coordinate of the point.
     */
    float _y;

    /**
     * @brief _z
     * The Z coordinate of the point.
     */
    float _z;
};

#endif