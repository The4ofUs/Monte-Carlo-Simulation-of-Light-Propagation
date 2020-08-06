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
        _radius = radius;
        _interface = c0;
        _remote = c1;
        _normal = MCMath::normalized(MC_Vector(c0, c1));
        _size = absorpCoeffs.size();
        _thickness = MCMath::absDistance(_interface, _remote);
        _portion = _thickness / (float) _size;
        for (int i = 0; i < _size; i++) {
            // This method of population the array with undefined Points is reckless and should be modified
            MC_Point interface =
                    _interface + _normal * ((float) i * _thickness / (float) _size);
            MC_Point remote =
                    _interface + _normal * ((float) (i + 1) * _thickness / (float) _size);
            _layers[i] = MC_Tissue(radius, interface, remote, absorpCoeffs[i],
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
    MC_Point Q = _interface;
    MC_Vector N = _normal;
    MC_Vector V = MC_Vector(Q, P);
    float d = abs(MCMath::dot(V, N));
    int index = (int) round((d / _thickness) * (float) _size);
    MC_Tissue currentTissue = _layers[index];
    return currentTissue;
}

__device__ bool MC_MLTissue::escaped(MC_Point const position) {
    MC_Point A = position;
    MC_Point B = _interface;
    MC_Vector C = _normal;
    float t = MCMath::dot(C, (A - B)) / MCMath::norm(C) * MCMath::norm(C);
    MC_Point P = B + C * t;
    float d = MCMath::absDistance(A, P);
    if (d > _radius) { return true; }
    float D = MCMath::norm(_remote - _interface);
    float E = MCMath::norm(P - _interface);
    if (E > D) { return true; }
    E = MCMath::norm((P - _remote));
    return E > D;
}

__device__ int MC_MLTissue::size() const {
    return _size;
}

__device__ float MC_MLTissue::coefficient(MC_Point position) { return whichLayer(position).attenuationCoefficient(); }

__device__ bool MC_MLTissue::isCrossing(MC_Path path) {
    /*
     * Distance of ray origin to the interface plane
     */
    float d1 = MCMath::point2PlaneDist(path.origin(), _interface, _normal);
    /*
     * Ignore the photons that already lay exactly on the boundary, it's highly likely that they were moved there by the
     * algorithm itself
     */
    if (fmod(d1, _portion) == 0.f) {
        return false;
    }
    /*
     * Distance of ray tip to the interface plane
     */
    float d2 = MCMath::point2PlaneDist(path.tip(), _interface, _normal);
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

/*
 * Calculate the point of intersection between the path and layer boundary
 */
__device__ void MC_MLTissue::updatePath(MC_Path& path) {
    /*
     * First we need to get a point on the boundary, however we need to determine some parameters first:
     * 1) Which direction did the crossing happen
     * 2) at which boundary
     */
    MC_Point coord = _interface * (1 - ((float) whichBoundary(path) * _portion));
    float d = MCMath::dot(_normal, coord);
    float t = (d - MCMath::dot(_normal, path.origin())) / MCMath::dot(_normal, path.direction());
    path.setTip(path.origin() + path.direction() * t);
}

__device__ int MC_MLTissue::whichBoundary(MC_Path path) {
    Direction direction;
    float d1 = MCMath::point2PlaneDist(path.origin(), _interface, _normal);
    float d2 = MCMath::point2PlaneDist(path.tip(), _interface, _normal);
    if ((d2 - d1) > 0) direction = DOWN;
    else direction = UP;
    int layerIdx = (int) floor(d1 / _portion);
    if (direction == DOWN) return layerIdx + 1;
    else return layerIdx;
}


MC_MLTissue::MC_MLTissue() = default;

