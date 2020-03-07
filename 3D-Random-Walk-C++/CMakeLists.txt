cmake_minimum_required(VERSION 3.0)

### c++11 standards
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)


set(HEADER_FILES
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

set(SOURCE_FILES
    code/src/RNG.cpp
    code/src/Ray.cpp
    code/src/Point.cpp
    code/src/Detector.cpp
    code/src/mathematics.cpp
    code/src/Vector.cpp
    code/src/Tissue.cpp
    code/src/Photon.cpp
)
include_directories( HEADER_FILES)

add_executable(
    #RandomWalk main.cpp  
    Test test_runs.cpp
    ${SOURCE_FILES}
    )

