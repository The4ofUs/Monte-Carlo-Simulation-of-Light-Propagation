//
// Created by mustafa on 6/4/20.
//

#include <stdexcept>
#include "../headers/MC_MLTissue.cuh"
#include "../headers/MC_Math.cuh"

__host__ MC_MLTissue::MC_MLTissue(float const radius, MC_Point const c0, MC_Point const c1,
                                  std::vector<float> const &absorpCoeffs,
                                  std::vector<float> const &scatterCoeffs) {
    if (radius > 0 && absorpCoeffs.size() == scatterCoeffs.size()) {
        this->_radius = radius;
        this->_interface = c0;
        this->_remote = c1;
        this->_normal = MCMath::normalized(MC_Vector(c0, c1));
        this->_size = absorpCoeffs.size();
        this->_thickness = MCMath::absDistance(this->_interface, this->_remote);
        for (int i = 0; i < this->_size; i++) {
            // This method of population the array with undefined Points is reckless and should be modified
            MC_Point interface =
                    this->_interface + this->_normal * ((float) i * this->_thickness / (float) this->_size);
            MC_Point remote =
                    this->_interface + this->_normal * ((float) (i + 1) * this->_thickness / (float) this->_size);
            this->_layers[i] = MC_Tissue(radius, interface, remote, absorpCoeffs[i],
                                         scatterCoeffs[i]);
        }
    } else { throw std::invalid_argument("MC_MLTissue::MC_MLTissue : Illegal Argument!"); }
}

__device__ void MC_MLTissue::attenuate(MC_Photon &photon) {
    MC_Tissue t = whichLayer(photon.position());
    t.attenuate(photon);
}

__device__ MC_Tissue MC_MLTissue::whichLayer(MC_Point const position) {
    /**
     * P : Current position of the photon
     * R : Projection of P on the tissue interface
     * Q : Point on the tissue interface ( Center of the interface for simplicity )
     * N : Normal to the interface
     * V : Vector from Q to P
     */
    MC_Point P = position;
    MC_Point Q = this->_interface;
    MC_Vector N = this->_normal;
    MC_Vector V = MC_Vector(Q, P);
    float d = abs(MCMath::dot(V, N));
    int index = (int) round((d / this->_thickness) * (float) this->_size);
    MC_Tissue currentTissue = this->_layers[index];
    return currentTissue;
}

__device__ bool MC_MLTissue::escaped(MC_Point const position) {
    MC_Point A = position;
    MC_Point B = this->_interface;
    MC_Vector C = this->_normal;
    float t = MCMath::dot(C, (A - B)) / MCMath::norm(C) * MCMath::norm(C);
    MC_Point P = B + C * t;
    float d = MCMath::absDistance(A, P);
    if (d > this->_radius) { return true; }
    float D = MCMath::norm(this->_remote - this->_interface);
    float E = MCMath::norm(P - this->_interface);
    if (E > D) { return true; }
    E = MCMath::norm((P - this->_remote));
    return E > D;
}

__device__ int MC_MLTissue::size() const {
    return this->_size;
}

__device__ float MC_MLTissue::coefficient(MC_Point position) { return whichLayer(position).attenuationCoefficient(); }

__device__ bool MC_MLTissue::isCrossing(MC_Path path) {
    /*
     * Vector from interface to path origin
     */
    MC_Vector v1 = MC_Vector(_interface, path.origin());
    /*
     * Vector from interface to path end
     */
    MC_Vector v2 = MC_Vector(_interface, path.tip());
    /*
     * Distance of ray origin to the interface plane
     */
    float d1 = abs(MCMath::dot(v1, _normal));
    /*
     * Distance of ray tip to the interface plane
     */
    float d2 = abs(MCMath::dot(v2, _normal));
    /*
     * Which portion the origin lies in
     */
    int q1 = (int) ((d1 / _thickness) * (float) _size);
    /*
     * Which portion the tip lies in
     */
    int q2 = (int) ((d2 / _thickness) * (float) _size);

    return q1 != q2;
}

__device__ MC_Point MC_MLTissue::crossingPoint(MC_Path path) {
    /*
     * TODO: Solve identifying the idx of the layer as duality of coordinates are mixing up negative and positive
     */
    /*
     * Calculate the point of intersection between the path and layer boundary
     */
    /*
     * Layer thickness
     */
    float portion = _thickness / (float) _size;
    /*
     * Vector from interface to path origin
     */
    MC_Vector v1 = MC_Vector(_interface, path.origin());
    /*
     * Perpendicular Distance of ray origin to the interface plane
     */
    float g = abs(MCMath::dot(v1, _normal));
    /*
     * idx of the current layer
     */
    int layerIdx = (int) (g / portion);
    /*
     * Distance of that boundary from the interface
     */
    float l = portion * ((float) layerIdx + 1);
    printf("Distance : %f\nidx : %d\n",l, layerIdx);
    /*
     * A Point on the boundary plane
     */
    MC_Point coord = _normal*l;
    float d = MCMath::dot(_normal,coord);
    /*
     * Parametrized step in the direction of the path to touch the boundary
     */
    float t = (d - MCMath::dot(_normal,path.origin()))/MCMath::dot(_normal,path.direction());
    /*
     * New tip that lies on the boundary
     */
    MC_Point newTip = path.origin() + path.direction() * t;
    return newTip;
}


MC_MLTissue::MC_MLTissue() = default;

