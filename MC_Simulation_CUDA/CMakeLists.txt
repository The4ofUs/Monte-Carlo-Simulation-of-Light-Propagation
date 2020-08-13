cmake_minimum_required(VERSION 3.10)

if(NOT CMAKE_CUDA_COMPILER)
    # The Path to NVCC compiler
    set(CMAKE_CUDA_COMPILER "/usr/lib/nvidia-cuda-toolkit/bin/nvcc")
endif()

set(EXECUTABLE_NAME MC_Simulation)

project(${EXECUTABLE_NAME} LANGUAGES CUDA CXX)

set(CMAKE_CUDA_STANDARD 14)


## To set archeticture correctly, check your GPU capabilities via nVidia website
#string(APPEND CMAKE_CUDA_FLAGS " -gencode arch=compute_20,code=sm_20 -Wno-deprecated-gpu-targets" )
set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS}; -rdc=true -lcudart -lcudadevrt -lcuda)

# Tell CMake to run moc when necessary:
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(CMAKE_CUDA_SEPARABLE_COMPILATION ON)
set (CUDA_RESOLVE_DEVICE_SYMBOLS ON)

set(CMAKE_CXX_FLAGS "-Wall -fPIC -std=c++11")
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall" "-fPIC-std=c++11")
#set( CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS} -g -ftest-coverage -fprofile-arcs" )

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
    code/headers/MC_RNG.cuh
    code/headers/MC_Point.cuh
    code/headers/MC_Vector.cuh
    code/headers/MC_Photon.cuh
    code/headers/MC_Path.cuh
    code/headers/MC_Tissue.cuh
    code/headers/MC_FiberGenerator.cuh
    code/headers/MC_RandomWalk.cuh
    code/headers/MC_Math.cuh
    code/headers/MC_Kernels.cuh
    code/headers/MC_Helpers.cuh
    code/headers/MC_MLTissue.cuh
    code/headers/MC_Simulation.cuh

)

set( CUDA_SOURCE_FILES
    code/src/MC_RNG.cu
    code/src/MC_Point.cu
    code/src/MC_Vector.cu
    code/src/MC_Photon.cu
    code/src/MC_Path.cu
    code/src/MC_Tissue.cu
    code/src/MC_FiberGenerator.cu
    code/src/MC_Math.cu
    code/src/MC_Kernels.cu
    code/src/MC_Helpers.cu
    code/src/MC_MLTissue.cu
    code/src/MC_Simulation.cu
)

set (NETWORK_HEADER_FILES
         Network/Client/Headers/socket.h
         Network/Client/Headers/ClientSocket.h
       )
set (NETWORK_SOURCE_FILES
        Network/Client/Sources/socket.cpp
        Network/Client/Sources/ClientSocket.cpp
       )
#set_target_properties(
#          ${EXECUTABLE_NAME}
#           PROPERTIES
#           CUDA_SEPARABLE_COMPILATION ON)

set(EXTRA_CXX_FLAGS "--std=c++11" CACHE STRING "common C++ build flags")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${EXTRA_CXX_FLAGS}")

#Build the rest of the executable.
cuda_add_executable(${EXECUTABLE_NAME} main.cu ${NETWORK_HEADER_FILES} ${NETWORK_SOURCE_FILES} ${CUDA_HEADER_FILES} ${CUDA_SOURCE_FILES})
#set_target_properties(
#          ${EXECUTABLE_NAME}
#           PROPERTIES
#           CUDA_RESOLVE_DEVICE_SYMBOLS ON
#           CUDA_SEPARABLE_COMPILATION ON)


#Remember dependencies!
target_link_libraries(${EXECUTABLE_NAME} Qt5::Widgets Qt5::Core Qt5::Network ${CUDA_LIBRARIES})

