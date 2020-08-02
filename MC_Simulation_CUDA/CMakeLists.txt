cmake_minimum_required(VERSION 3.10)
project(MC_Simulation CUDA)

set(CMAKE_CUDA_STANDARD 14)

add_executable(MC_Simulation main.cu code/src/MC_RNG.cu code/headers/MC_RNG.cuh code/src/MC_Point.cu code/headers/MC_Point.cuh code/src/MC_Vector.cu code/headers/MC_Vector.cuh code/src/MC_Photon.cu code/headers/MC_Photon.cuh code/src/MC_Ray.cu code/headers/MC_Ray.cuh code/src/MC_Tissue.cu code/headers/MC_Tissue.cuh code/src/MC_Detector.cu code/headers/MC_Detector.cuh code/headers/MC_RandomWalk.cuh code/src/MC_Math.cu code/headers/MC_Math.cuh code/headers/MC_Kernels.cuh code/src/MC_Kernels.cu code/headers/MC_Helpers.cuh code/src/MC_Helpers.cu code/src/MC_MLTissue.cu code/headers/MC_MLTissue.cuh code/src/MC_Simulation.cu code/headers/MC_Simulation.cuh)

set_target_properties(
        MC_Simulation
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
