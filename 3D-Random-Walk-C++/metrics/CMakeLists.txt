cmake_minimum_required(VERSION 3.0)

### c++11 standards
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
#/home/gamila/Documents/GP/Task4-RandomWalkCUDA/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/headers/common.h

set(HEADER_FILES
    3D-Random-Walk-C++/code/headers/Point.h
    3D-Random-Walk-C++/code/headers/RNG.h
    3D-Random-Walk-C++/code/headers/Ray.h
    3D-Random-Walk-C++/code/headers/randomwalk.h
    3D-Random-Walk-C++/code/headers/common.h
    3D-Random-Walk-C++/code/headers/Detector.h
    3D-Random-Walk-C++/code/headers/Vector.h
    3D-Random-Walk-C++/code/headers/Tissue.h
    3D-Random-Walk-C++/code/headers/Photon.h
    3D-Random-Walk-C++/code/headers/mathematics.h
)

set(SOURCE_FILES
    ~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/src/RNG.cpp
    ~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/src/Ray.cpp
    ~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/src/Point.cpp
    ~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/src/Detector.cpp
    ~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/src/mathematics.cpp
    ~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/src/Vector.cpp
    ~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/src/Tissue.cpp
    ~/3D-Random-Walk-CUDA/3D-Random-Walk-C++/code/src/Photon.cpp
)
include_directories( HEADER_FILES)

add_executable(
    Test test_runs.cpp  
    ${SOURCE_FILES}
    )
