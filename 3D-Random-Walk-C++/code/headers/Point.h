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
    
    Point(float x, float y, float z);

    /**
     * @brief Constructor
     */
    
    Point();

    /**
     * @brief setCoordinates
     * Updates the coordinates of the point to the given ones.
     * @param x (float)
     * @param y (float)
     * @param z (float)
     */
     void setCoordinates(float x, float y, float z);

    /**
     * @return The X coordinate of the point.
     */
     float x() const;

    /**
     * @return The Y coordinate of the point.
     */
     float y() const;

    /**
     * @return The Z coordinate of the point.
     */
     float z() const;

    /**
     * Overloading the + operator
     */
    
        Point
        operator+(Point const &other);

    /**
     * Overloading the - operator
     */
    
        Point
        operator-(Point const &other);

    /**
     * Overloading the * operator
     */
    
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