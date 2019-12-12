#include "Vector.h"
#include "Point.h"
#include "Ray.h"
#include "Vector.cu"
#include "Point.cu"
#include "Ray.cu"


/**
    TODO: 
        1- Check if the photon is out of radial boundary
        2- Check if Photon is out of axial boundary

        (1) 
        AxisDirection = (center1 - center0)     // Won't matter because we are dealing with abs distances
        P = Center + AxisDirection*t      //Point on the cylinder axis
        V1 = P1 - P     // P1 is the position of the photon
        V1 = P1 - Center - AxisDirection*t
        V1.AxisDirection = 0
        (P1 - Center - AxisDirection*t).AxisDirection = 0
        (P1x - Centerx - AxisDirectionx*t)*AxisDirectionx + 
        (P1y - Centery - AxisDirectiony*t)*AxisDirectiony + 
        (P1z - Centerz - AxisDirectionz*t)*AxisDirectionz = 0 
        
        t = C . (A - B) / ||C||^2

        where
        A : Photon Position
        B : Center of one of the two circular faces of the cylinder
        C : Axis Direction



        (2)
        D = (Center1 - Center0).getAbsDistance()
*/



class Tissue
{
public:
    __host__ Tissue(float radius, Point c0, Point c1)
    {
        this->_radius = radius;
        this->_center0 = c0;
        this->_center1 = c1;
        this->_axis = Vector(c0,c1).normalize();
    }
    
    __host__ bool escaped(Point point){
        Point A = point;
        Point B = this->_center0;
        Vector C = this->_axis;
        printf("A = (%f,%f,%f)\nB = (%f,%f,%f)\nC = (%f,%f,%f)\n", A.x(),A.y(),A.z(),B.x(),B.y(),B.z(),C.x(),C.y(),C.z());
        float t = C.dot(A - B)/ C.getAbsDistance()*C.getAbsDistance();
        Point P = B + C*t;
        printf("t = %f\nP = (%f,%f,%f)\n", t,P.x(),P.y(),P.z());
        float d = A.getAbsDistance(P);
        printf("d = %f\n", d);
        if(d > this->_radius){
            return true;
        }
        float D = (this->_center1 - this->_center0).getAbsDistance();
        float E = (P - this->_center0).getAbsDistance();
        printf("D = %f\nE = %f\n", D, E);
        if(E > D){
            return true;
        }
        E = (P - this->_center1).getAbsDistance();
        if(E > D){
            return true;
        }
        return false;
    }
    Vector getAxis(){
        return this->_axis;
    }

private:
    float _radius;
    Point _center0;
    Point _center1;
    Vector _axis;
};


int main(){
    Tissue tissue = Tissue(5.f,Point(-3.f,0.f,0.f),Point(3.f,0.f,0.f));
    Vector Axis = tissue.getAxis();
    Point P = Point(-4.f,3.f,0.f);
    bool didEscape = tissue.escaped(P);
    printf("Tissue Axis = (%f,%f,%f)\n",Axis.x(), Axis.y(), Axis.z());
    printf("Point current position = (%f,%f,%f)\n",P.x(), P.y(), P.z());
    printf("Did the ray escape? %d\n", didEscape);
    return 0;
}
