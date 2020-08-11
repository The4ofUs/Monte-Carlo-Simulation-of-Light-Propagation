//
// Created by mustafa on 6/4/20.
//

#include <stdexcept>
#include "../headers/MC_MLTissue.cuh"
#include "../headers/MC_Math.cuh"
#include <cassert>
#include <math.h>

__host__ MC_MLTissue::MC_MLTissue(float const radius, MC_Point const c0, MC_Point const c1,
                                  std::vector<float> const &absorpCoeffs,
                                  std::vector<float> const &scatterCoeffs, std::vector<float> const &refractIndices) {
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
                                   scatterCoeffs[i], refractIndices[i]);
        }
    } else { throw std::invalid_argument("MC_MLTissue::MC_MLTissue : Illegal Argument!"); }
}

__device__ void MC_MLTissue::attenuate(MC_Photon &photon) {
    MC_Tissue t = getLayer(whichLayer(photon.position()));
    t.attenuate(photon);
}

__device__ __host__ int MC_MLTissue::whichLayer(MC_Point const position) {
    float d = MCMath::point2PlaneDist(position, _interface, _normal);
    int index = (int) floor(d / _portion);
    return index;
}

__device__ MC_Tissue MC_MLTissue::getLayer(int const idx) {
    assert(idx < _size);
    return _layers[idx];
}

__device__ bool MC_MLTissue::escaped(MC_Path const path) {
    MC_Point A = path.tip();
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

__device__ float MC_MLTissue::coefficient(MC_Point position) {
    return getLayer(whichLayer(position)).attenuationCoefficient();
}

__device__ __host__ bool MC_MLTissue::isCrossing(MC_Path path) {
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
__device__ void MC_MLTissue::updatePath(MC_Path &path) {
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
    Direction direction = whichDirection(path);
    float d1 = MCMath::point2PlaneDist(path.origin(), _interface, _normal);
    int layerIdx = (int) floor(d1 / _portion);
    if (direction == DOWN) return layerIdx + 1;
    else return layerIdx;
}

__device__ MC_MLTissue::Direction MC_MLTissue::whichDirection(const MC_Path path) {
    float d1 = MCMath::point2PlaneDist(path.origin(), _interface, _normal);
    float d2 = MCMath::point2PlaneDist(path.tip(), _interface, _normal);
    if ((d2 - d1) > 0) return DOWN;
    else return UP;
}

__device__ __host__ bool MC_MLTissue::onBoundary(const MC_Path path) {
    return fmod(MCMath::point2PlaneDist(path.tip(), _interface, _normal), _portion) == 0;
}

__device__ int MC_MLTissue::nextLayer(int idx, Direction dir) const {
    if (dir == UP) {
        if (idx > 0) return idx - 1;
        else return idx;
    } else {
        if (idx < _size - 1) return idx + 1;
        else return idx;
    }
}

__device__ bool MC_MLTissue::isReflected(MC_Path path, float random) {
    float incidentAngle = acos(abs(path.direction().z()));
    int idx1 = whichLayer(path.origin()) - 1;
    int idx2 = nextLayer(idx1, whichDirection(path));
    float ni = getLayer(idx1).n();
    float nt = getLayer(idx2).n();
    float R;
    if (ni > nt) {
        return true;
    } else {
        float transmitAngle = asin(((ni * sin(incidentAngle)) / nt));
        float term_1 = sin(incidentAngle - transmitAngle);
        float term_2 = sin(incidentAngle + transmitAngle);
        float term_3 = tan(incidentAngle - transmitAngle);
        float term_4 = tan(incidentAngle + transmitAngle);
        R = 0.5f * ((term_1 / term_2) + (term_3 / term_4));
        printf("------------- isReflected() -------------\nmue = %f\nincident angle = %f\ntransmitting angle = %f\nni = %f\nnt = %f\nterm_1 = %f\nterm_2 = %f\nterm_3 = %f\nterm_4 = %f\n",
               path.direction().z(),
               incidentAngle, transmitAngle, ni, nt, term_1, term_2, term_3, term_4);
        if (R >= random) return true;
        return false;
    }
}

__device__ void MC_MLTissue::reflect(MC_Path &path, float const step) {
/*    MC_Point origin_orig = path.origin();
    MC_Point tip_orig = path.tip();*/
    path = MC_Path(path.tip(), MC_Vector(path.direction().x(), path.direction().y(), -1 * path.direction().z()), step);
/*    printf("reflect() :\n\tReflection Event:\n\t\tIncident :\n\t\t\torigin = (%f, %f, %f)\n\t\t\ttip = (%f, %f, %f)\n\t\tReflected :\n\t\t\torigin = (%f, %f, %f)\n\t\t\ttip = (%f, %f, %f)\n",
           origin_orig.x(), origin_orig.y(), origin_orig.z(), tip_orig.x(), tip_orig.y(), tip_orig.z(),
           path.origin().x(), path.origin().y(), path.origin().z(), path.tip().x(), path.tip().y(), path.tip().z());*/
}

__device__ void MC_MLTissue::refract(MC_Path &path, float const step) {
/*    MC_Point origin_orig = path.origin();
    MC_Point tip_orig = path.tip();*/
    float ni = getLayer(whichLayer(path.origin())).n();
    float nt = getLayer(whichLayer(path.tip())).n();
    float n = ni / nt;
    float cosI = -1 * MCMath::dot(_normal, path.direction());
    float sinT2 = n * n * (1.f - cosI * cosI);
    if (sinT2 > 1.f) printf("Error in refraction: sinT2 > 1.f\n");
    float cosT = sqrt(1.f - sinT2);
    MC_Vector newDirection = path.direction() * n + _normal * (n * cosT - cosT);
    path = MC_Path(path.tip(), newDirection, step);
/*    printf("refract() :\n\tRefraction Event:\n\t\tIncident :\n\t\t\torigin = (%f, %f, %f)\n\t\t\ttip = (%f, %f, %f)\n\t\tRefracted :\n\t\t\torigin = (%f, %f, %f)\n\t\t\ttip = (%f, %f, %f)\n",
           origin_orig.x(), origin_orig.y(), origin_orig.z(), tip_orig.x(), tip_orig.y(), tip_orig.z(),
           path.origin().x(), path.origin().y(), path.origin().z(), path.tip().x(), path.tip().y(), path.tip().z());*/
}

MC_MLTissue::MC_MLTissue() = default;

