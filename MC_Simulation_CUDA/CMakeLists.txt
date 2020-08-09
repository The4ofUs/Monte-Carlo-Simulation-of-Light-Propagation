cmake_minimum_required(VERSION 3.16)
set(EXECUTABLE_NAME MC_simulation)
project(${EXECUTABLE_NAME})

# Tell CMake to run moc when necessary:
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

SET(CUDA_SEPARABLE_COMPILATION ON)
set(CMAKE_CXX_FLAGS "-Wall -fPIC -std=c++11")
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall" "-fPIC-std=c++11")

# As moc files are generated in the binary dir, tell CMake
# to always look for includes there:
set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt5Network REQUIRED)
find_package(Qt5Core REQUIRED)
find_package(Qt5Widgets REQUIRED)
find_package(Qt5 COMPONENTS Network Core Widgets Gui REQUIRED)
find_package(CUDA REQUIRED)

# set up a mapping so that the Release configuration for the Qt imported target is
# used in the COVERAGE CMake configuration.
set_target_properties(Qt5::Core PROPERTIES MAP_IMPORTED_CONFIG_COVERAGE "RELEASE")
set_target_properties(Qt5::Network PROPERTIES MAP_IMPORTED_CONFIG_COVERAGE "RELEASE")


set( CUDA_HEADER_FILES
    code/headers/MC_Point.cuh
    code/headers/MC_RNG.cuh
    code/headers/MC_Ray.cuh
    code/headers/MC_RandomWalk.cuh
    code/headers/MC_Detector.cuh
    code/headers/MC_Vector.cuh
    code/headers/MC_Tissue.cuh
    code/headers/MC_MLTissue.cuh
    code/headers/MC_Photon.cuh
    code/headers/MC_Math.cuh
    code/headers/MC_Helpers.cuh
    code/headers/MC_Kernels.cuh
)

set( CUDA_SOURCE_FILES
    code/src/MC_RNG.cu
    code/src/MC_Ray.cu
    code/src/MC_Point.cu
    code/src/MC_Detector.cu
    code/src/MC_Math.cu
    code/src/MC_Vector.cu
    code/src/MC_Tissue.cu
    code/src/MC_MLTissue.cu
    code/src/MC_Photon.cu
    code/src/MC_Helpers.cu
    code/src/MC_Kernels.cu
)

set (NETWORK_HEADER_FILES
    Network/Client/Headers/socket.h
     Network/Client/Headers/ClientSocket.h
   )
set (NETWORK_SOURCE_FILES
    Network/Client/Sources/socket.cpp
    Network/Client/Sources/ClientSocket.cpp
   )

 set(EXTRA_CXX_FLAGS "--std=c++11" CACHE STRING "common C++ build flags")
 set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${EXTRA_CXX_FLAGS}")

#Build the rest of the executable.
cuda_add_executable(${EXECUTABLE_NAME} main.cu ${NETWORK_HEADER_FILES} ${NETWORK_SOURCE_FILES} ${CUDA_HEADER_FILES} ${CUDA_SOURCE_FILES})
#Remember dependencies!
target_link_libraries(${EXECUTABLE_NAME} Qt5::Widgets Qt5::Core Qt5::Network ${CUDA_LIBRARIES})

