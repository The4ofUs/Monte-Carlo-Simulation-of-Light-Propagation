cmake_minimum_required(VERSION 3.0)
find_package(CUDA REQUIRED)

SET(CUDA_SEPARABLE_COMPILATION ON)

set( CUDA_HEADER_FILES
    code/headers/Point.h
    code/headers/RNG.h
    code/headers/Ray.h
    code/headers/randomwalk.h
    code/headers/common.h
    code/headers/Detector.h
    code/headers/Vector.h
    code/headers/Tissue.h
    code/headers/Photon.h
    code/headers/mathematics.h
)

set( CUDA_SOURCE_FILES
    code/src/RNG.cu
    code/src/Ray.cu
    code/src/Point.cu
    code/src/Detector.cu
    code/src/mathematics.cu
    code/src/Vector.cu
    code/src/Tissue.cu
    code/src/Photon.cu
)


cuda_add_executable(
    RandomWalk main.cu
    #Test test_runs.cu
    ${CUDA_SOURCE_FILES}
    ${CUDA_HEADER_FILES}
    )

