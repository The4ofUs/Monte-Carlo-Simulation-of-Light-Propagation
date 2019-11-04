# Minimim cuda version required to compile the project
cmake_minimum_required(VERSION 3.0)

# Project name
project('RandomWalk')

# Required packages should be added to the cmake directory 
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(CUDA)
include(CUDA_SDK) 

# For separate compilation into multiple CUDA objects
SET(CUDA_SEPARABLE_COMPILATION ON)

# Header files
set(CUDA_HEADER_FILES
    src/Point.h
    src/RNG.h
    src/Ray.h
    src/RandomWalk.h
    src/header.h
)

# Source files
set(CUDA_SOURCE_FILES
    src/RNG.cu
    src/Ray.cu
    src/Point.cu
)

# Create an executable that can run on the GPU.
cuda_add_executable(
    randomWalk src/main.cu
    ${CUDA_SOURCE_FILES}
    ${CUDA_HEADER_FILES}
    )
