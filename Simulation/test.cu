//
// Created by mostafa on ١١‏/٨‏/٢٠٢٠.
//

#include "code/headers/MC_MLTissue.cuh"
#include "code/headers/MC_Path.cuh"
#include "code/headers/MC_Point.cuh"
#include <cstdio>

#define TISSUE_RADIUS 100.f
#define TISSUE_CENTER_1 MC_Point(0.f, 0.f, 1.f)
#define TISSUE_CENTER_2 MC_Point(0.f, 0.f, 0.f)
#define A_COEFFICIENTS std::vector<float> {1.f, 6.f, 4.f, 2.f}
#define S_COEFFICIENTS std::vector<float> {100.f, 30.f, 12.f, 20.f}
#define R_INDICES std::vector<float> {0.5f, 0.3f, 0.2f, 0.8f}

void whichLayer_TEST() {
    printf("------------------- whichLayer() Test ------------------- \n");
    MC_MLTissue mcMlTissue = MC_MLTissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, A_COEFFICIENTS,
                                         S_COEFFICIENTS, R_INDICES);
    MC_Path path = MC_Path(MC_Point(0.1, 0.2, 0.76), MC_Vector(0.f, 0.f, -1.f), 0.01);
    printf("Path :\n\tOrigin : (%f, %f, %f)\n\tDirection : (%f, %f, %f)\n\tStep : %f\n\tTip : (%f, %f, %f)\n",
           path.origin().x(), path.origin().y(), path.origin().z(), path.direction().x(), path.direction().y(),
           path.direction().z(), 0.01, path.tip().x(), path.tip().y(), path.tip().z());
    if (mcMlTissue.whichLayer(path.tip()).n() == 0.3f){
        printf("whichLayer() : Executed Correctly!\n");
    } else printf("whichLayer() : Not Executed Correctly!")
}

void onBoundary_TEST(){
    printf("------------------- onBoundary() Test ------------------- \n");
    MC_MLTissue mcMlTissue = MC_MLTissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, A_COEFFICIENTS,
                                         S_COEFFICIENTS, R_INDICES);
    MC_Path path = MC_Path(MC_Point(0.1, 0.2, 0.76), MC_Vector(0.f, 0.f, -1.f), 0.01);
    printf("Path :\n\tOrigin : (%f, %f, %f)\n\tDirection : (%f, %f, %f)\n\tStep : %f\n\tTip : (%f, %f, %f)\n",
           path.origin().x(), path.origin().y(), path.origin().z(), path.direction().x(), path.direction().y(),
           path.direction().z(), 0.01, path.tip().x(), path.tip().y(), path.tip().z());
    if (mcMlTissue.onBoundary(path)){
        printf("onBoundary() : Executed Correctly!\n");
    } else printf("onBoundary() : Not Executed Correctly!");
}

void isCrossing_TEST() {
    printf("------------------- isCrossing() Test ------------------- \n");
    MC_MLTissue mcMlTissue = MC_MLTissue(TISSUE_RADIUS, TISSUE_CENTER_1, TISSUE_CENTER_2, A_COEFFICIENTS,
                                         S_COEFFICIENTS, R_INDICES);
    MC_Path path = MC_Path(MC_Point(0.1, 0.2, 0.74), MC_Vector(0.f, 0.f, 1.f), 0.02);
    printf("Path :\n\tOrigin : (%f, %f, %f)\n\tDirection : (%f, %f, %f)\n\tStep : %f\n\tTip : (%f, %f, %f)\n",
           path.origin().x(), path.origin().y(), path.origin().z(), path.direction().x(), path.direction().y(),
           path.direction().z(), 0.01, path.tip().x(), path.tip().y(), path.tip().z());
    if (mcMlTissue.isCrossing(path)){
        printf("isCrossing() : Executed Correctly!");
    } else printf("isCrossing() : Not Executed Correctly!");
}

int main() {
    whichLayer_TEST();
    onBoundary_TEST();
    isCrossing_TEST();
}

