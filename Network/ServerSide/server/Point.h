#ifndef POINT_H
#define POINT_H

/*
 * A point in the space defined by the cartesian coordinates (X, Y, Z)
 */
class Point
{

public:

    Point(double x, double y, double z);

    Point();


    void setCoordinates(double x, double y, double z);
    double x();
    double y();
    double z();





protected:

    double _x;
    double _y;
    double _z;
};

#endif
