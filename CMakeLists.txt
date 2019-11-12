cmake_minimum_required(VERSION 3.0)
find_package(CUDA REQUIRED)

SET(CUDA_SEPARABLE_COMPILATION ON)

set( CUDA_HEADER_FILES
    src/Point.h
    src/RNG.h
    src/Ray.h
    src/RandomWalk.h
    src/Boundary.h
    src/header.h
)

set( CUDA_SOURCE_FILES
    src/RNG.cu
    src/Ray.cu
    src/Point.cu
    src/Boundary.cu
)


cuda_add_executable(
    randomWalk src/main.cu
    ${CUDA_SOURCE_FILES}
    ${CUDA_HEADER_FILES}
    )

