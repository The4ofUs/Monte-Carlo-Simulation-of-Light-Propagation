#include "Point.h"
#include "Point.cu"
#include "RNG.h"
#include "RNG.cu"
#include "Vector.h"
#include "Vector.cu"
#include <array>

#define NUMBER_OF_SAMPLES 100


void streamOut(std::array<Vector, NUMBER_OF_SAMPLES> vectors)  
{
    FILE *output;
    output = fopen("detector.csv", "w+");
    for(int i = 0; i < vectors.size(); i++)
    fprintf(output, "%f,%f,%f\n", vectors[i].x(), vectors[i].y(), vectors[i].z());
}

class Detector
{

public:
    __host__ Detector(float radius, Point center, Vector normal){
        if(radius > 0){
            this->_radius = radius;
            this->_center = center;
            this->_normal = normal.normalize();
            construct();
        }
    }

    __host__ void construct(){
        RNG rng;
        float r = this->_radius;
        float dtheta = 2* M_PI / NUMBER_OF_SAMPLES;
        Point P = rng.getRandomPoint();
        printf("P = (%f,%f,%f) \n", P.x(),P.y(),P.z());
        Point P1 = this->_center;
        printf("P1 = (%f,%f,%f) \n", P1.x(),P1.y(),P1.z());
        Vector P_P1 = Vector(P1,P);
        printf("P - P1 = (%f,%f,%f) \n", P_P1.x(),P_P1.y(),P_P1.z());
        Vector P2_P1 = this->_normal;
        printf("P2 - P1 = (%f,%f,%f) \n", P2_P1.x(),P2_P1.y(),P2_P1.z());
        Vector R = P_P1.cross(P2_P1);
        printf("R = (%f,%f,%f) \n", R.x(),R.y(),R.z());
        Vector S = R.cross(P2_P1);
        printf("S = (%f,%f,%f) \n", S.x(),S.y(),S.z());
        Vector normalizedR = R.normalize();
        printf("Norm R = (%f,%f,%f) \n", normalizedR.x(),normalizedR.y(),normalizedR.z());
        Vector normalizedS = S.normalize();
        printf("Norm S = (%f,%f,%f) \n", normalizedS.x(),normalizedS.y(),normalizedS.z());
        Vector Q = Vector();
        std::array<Vector, NUMBER_OF_SAMPLES> disc;
        int i = 0;
        printf("------------------------------------------------------------------------------------------------------------------------------ \n");
        for(float theta = 0; theta < 2*M_PI; theta+=dtheta){
            Q = P1 + R*(r*cos(theta)) + S*(r*sin(theta));
            Q = Q.normalize();
            printf("%i) Q = (%f,%f,%f) \n", i+1, Q.x(), Q.y(), Q.z());
            disc[i++] = Q;
        }
        streamOut(disc);
    }

private:
    float _radius;
    Point _center;
    Vector _normal;
};


int main(){
    Detector detector = Detector(1.0, Point(0.f,0.f,0.f), Point(1.f,1.f,1.f));
    return 0;
}





