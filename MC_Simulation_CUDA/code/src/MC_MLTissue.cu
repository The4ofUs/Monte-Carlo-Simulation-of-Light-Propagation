//
// Created by mustafa on 6/4/20.
//

#include <stdexcept>
#include "../headers/MC_MLTissue.cuh"
#include "../headers/MC_Math.cuh"

__host__ MC_MLTissue::MC_MLTissue(float const radius, MC_Point const c0, MC_Point const c1,
                                  std::vector<float> const &absorptionCoefficients,
                                  std::vector<float> const &scatteringCoefficients) {
    if (radius > 0 && absorptionCoefficients.size() == scatteringCoefficients.size()) {
        this->_radius = radius;
        this->_interface = c0;
        this->_remote = c1;
        this->_normal = MCMath::normalized(MC_Vector(c0, c1));
        this->_size = absorptionCoefficients.size();
        this->_thickness = MCMath::absDistance(this->_interface, this->_remote);
        for (int i = 0; i < this->_size; i++) {
            // This method of population the array with undefined Points is reckless and should be modified
            MC_Point interface =
                    this->_interface + this->_normal * ((float) i * this->_thickness / (float) this->_size);
            MC_Point remote =
                    this->_interface + this->_normal * ((float) (i + 1) * this->_thickness / (float) this->_size);
            this->_layers[i] = MC_Tissue(radius, interface, remote, absorptionCoefficients[i], scatteringCoefficients[i]);
        }
    } else { throw std::invalid_argument("MC_MLTissue::MC_MLTissue : Illegal Argument!"); }
}

__host__ void MC_MLTissue::verbose() {
    printf("Tissue Radius : %f\nTissue Interface side position : (%f,%f,%f)\nTissue Remote side position : (%f,%f,%f)\nThickness : %f\nTissue Normal Vector : (%f,%f,%f)\nNumber of layers : %d\n\n--- Layers Properties ---",
           this->_radius, this->_interface.x(), this->_interface.y(), this->_interface.z(), this->_remote.x(),
           this->_remote.y(),
           this->_remote.z(), this->_thickness, this->_normal.x(), this->_normal.y(), this->_normal.z(), this->_size);
    for (int i = 0; i < this->_size; i++) {
        MC_Tissue current = this->_layers[i];
        printf("\nLayer #%d\nRadius : %f\nInterface : (%f,%f,%f)\nRemote : (%f,%f,%f)\nThickness : %f\nAbsorption Coefficient : %f\nScattering Coefficient : %f\nAttenuation Coefficient : %f\n",
               i, current.radius(), current.interface().x(), current.interface().y(), current.interface().z(),
               current.remote().x(),
               current.remote().y(), current.remote().z(), current.thickness(),
               current.absorption(), current.scattering(), current.attenuationCoefficient());
    }
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
    float t =
            MCMath::dot(C, (A - B)) / MCMath::norm(C) * MCMath::norm(C);
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
    return _size;
}

__device__ float MC_MLTissue::attenuationCoefficient(MC_Point const position) {
    MC_Tissue t = whichLayer(position);
    return t.attenuationCoefficient();
}

MC_MLTissue::MC_MLTissue() = default;

