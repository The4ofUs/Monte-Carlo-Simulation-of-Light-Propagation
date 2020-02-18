cmake_minimum_required(VERSION 3.0)
find_package(CUDA REQUIRED)

SET(CUDA_SEPARABLE_COMPILATION ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
project(NetworkDemo)
if(CMAKE_VERSION VERSION_LESS "3.7.0")
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

find_package(Qt5 COMPONENTS Widgets Network Core  REQUIRED)
find_package(Qt5Network)

target_link_libraries(NetworkDemo Qt5::Widgets Qt5::Core Qt5::Network)

get_target_property(QtCore_location Qt5::Core LOCATION)
get_target_property(QtNetwork_location Qt5::Network "/usr/include/x86_64-linux-gnu/qt5/QtNetwork")


set(CMAKE_CXX_FLAGS_COVERAGE "${CMAKE_CXX_FLAGS_RELEASE} -fprofile-arcs -ftest-coverage")

# set up a mapping so that the Release configuration for the Qt imported target is
# used in the COVERAGE CMake configuration.
set_target_properties(Qt5::Core PROPERTIES MAP_IMPORTED_CONFIG_COVERAGE "RELEASE")
set_target_properties(Qt5::Network PROPERTIES MAP_IMPORTED_CONFIG_COVERAGE "RELEASE")

set ( NETWORK_FILES
Network/Headers/socket.h
Network/Sources/socket.cpp)
    


cuda_add_executable(
    NetworkDemo main.cu
    ${NETWORK_FILES}
    )
