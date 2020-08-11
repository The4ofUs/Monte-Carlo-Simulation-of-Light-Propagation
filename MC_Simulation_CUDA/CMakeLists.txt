cmake_minimum_required(VERSION 3.10)



if(NOT CMAKE_CUDA_COMPILER)
    # The Path to NVCC compiler
    set(CMAKE_CUDA_COMPILER "/usr/local/cuda-11.0/bin/nvcc")
endif()

project(MC_Simulation CUDA)

set(CMAKE_CUDA_STANDARD 14)


# To set archeticture correctly, check your GPU capabilities via nVidia website
string(APPEND CMAKE_CUDA_FLAGS " -gencode arch=compute_50,code=sm_50 -Wno-deprecated-gpu-targets")

add_executable(MC_Simulation main.cu code/src/MC_RNG.cu code/headers/MC_RNG.cuh code/src/MC_Point.cu code/headers/MC_Point.cuh code/src/MC_Vector.cu code/headers/MC_Vector.cuh code/src/MC_Photon.cu code/headers/MC_Photon.cuh code/src/MC_Path.cu code/headers/MC_Path.cuh code/src/MC_Tissue.cu code/headers/MC_Tissue.cuh code/src/MC_FiberGenerator.cu code/headers/MC_FiberGenerator.cuh code/headers/MC_RandomWalk.cuh code/src/MC_Math.cu code/headers/MC_Math.cuh code/headers/MC_Kernels.cuh code/src/MC_Kernels.cu code/headers/MC_Helpers.cuh code/src/MC_Helpers.cu code/src/MC_MLTissue.cu code/headers/MC_MLTissue.cuh code/src/MC_Simulation.cu code/headers/MC_Simulation.cuh)

set_target_properties(
        MC_Simulation
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
