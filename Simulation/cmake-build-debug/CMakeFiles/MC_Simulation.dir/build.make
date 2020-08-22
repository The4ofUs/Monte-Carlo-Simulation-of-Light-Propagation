# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.17

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/mostafa/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/202.6397.106/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/mostafa/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/202.6397.106/bin/cmake/linux/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/MC_Simulation.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/MC_Simulation.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/MC_Simulation.dir/flags.make

CMakeFiles/MC_Simulation.dir/main.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/main.cu.o: ../main.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CUDA object CMakeFiles/MC_Simulation.dir/main.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/main.cu -o CMakeFiles/MC_Simulation.dir/main.cu.o

CMakeFiles/MC_Simulation.dir/main.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/main.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/main.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/main.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_RNG.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/code/src/MC_RNG.cu.o: ../code/src/MC_RNG.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CUDA object CMakeFiles/MC_Simulation.dir/code/src/MC_RNG.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/code/src/MC_RNG.cu -o CMakeFiles/MC_Simulation.dir/code/src/MC_RNG.cu.o

CMakeFiles/MC_Simulation.dir/code/src/MC_RNG.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/code/src/MC_RNG.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_RNG.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/code/src/MC_RNG.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Point.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/code/src/MC_Point.cu.o: ../code/src/MC_Point.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CUDA object CMakeFiles/MC_Simulation.dir/code/src/MC_Point.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/code/src/MC_Point.cu -o CMakeFiles/MC_Simulation.dir/code/src/MC_Point.cu.o

CMakeFiles/MC_Simulation.dir/code/src/MC_Point.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/code/src/MC_Point.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Point.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/code/src/MC_Point.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Vector.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/code/src/MC_Vector.cu.o: ../code/src/MC_Vector.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CUDA object CMakeFiles/MC_Simulation.dir/code/src/MC_Vector.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/code/src/MC_Vector.cu -o CMakeFiles/MC_Simulation.dir/code/src/MC_Vector.cu.o

CMakeFiles/MC_Simulation.dir/code/src/MC_Vector.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/code/src/MC_Vector.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Vector.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/code/src/MC_Vector.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Photon.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/code/src/MC_Photon.cu.o: ../code/src/MC_Photon.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CUDA object CMakeFiles/MC_Simulation.dir/code/src/MC_Photon.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/code/src/MC_Photon.cu -o CMakeFiles/MC_Simulation.dir/code/src/MC_Photon.cu.o

CMakeFiles/MC_Simulation.dir/code/src/MC_Photon.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/code/src/MC_Photon.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Photon.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/code/src/MC_Photon.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Path.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/code/src/MC_Path.cu.o: ../code/src/MC_Path.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CUDA object CMakeFiles/MC_Simulation.dir/code/src/MC_Path.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/code/src/MC_Path.cu -o CMakeFiles/MC_Simulation.dir/code/src/MC_Path.cu.o

CMakeFiles/MC_Simulation.dir/code/src/MC_Path.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/code/src/MC_Path.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Path.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/code/src/MC_Path.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Tissue.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/code/src/MC_Tissue.cu.o: ../code/src/MC_Tissue.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CUDA object CMakeFiles/MC_Simulation.dir/code/src/MC_Tissue.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/code/src/MC_Tissue.cu -o CMakeFiles/MC_Simulation.dir/code/src/MC_Tissue.cu.o

CMakeFiles/MC_Simulation.dir/code/src/MC_Tissue.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/code/src/MC_Tissue.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Tissue.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/code/src/MC_Tissue.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_FiberGenerator.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/code/src/MC_FiberGenerator.cu.o: ../code/src/MC_FiberGenerator.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CUDA object CMakeFiles/MC_Simulation.dir/code/src/MC_FiberGenerator.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/code/src/MC_FiberGenerator.cu -o CMakeFiles/MC_Simulation.dir/code/src/MC_FiberGenerator.cu.o

CMakeFiles/MC_Simulation.dir/code/src/MC_FiberGenerator.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/code/src/MC_FiberGenerator.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_FiberGenerator.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/code/src/MC_FiberGenerator.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Math.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/code/src/MC_Math.cu.o: ../code/src/MC_Math.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CUDA object CMakeFiles/MC_Simulation.dir/code/src/MC_Math.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/code/src/MC_Math.cu -o CMakeFiles/MC_Simulation.dir/code/src/MC_Math.cu.o

CMakeFiles/MC_Simulation.dir/code/src/MC_Math.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/code/src/MC_Math.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Math.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/code/src/MC_Math.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Kernels.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/code/src/MC_Kernels.cu.o: ../code/src/MC_Kernels.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Building CUDA object CMakeFiles/MC_Simulation.dir/code/src/MC_Kernels.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/code/src/MC_Kernels.cu -o CMakeFiles/MC_Simulation.dir/code/src/MC_Kernels.cu.o

CMakeFiles/MC_Simulation.dir/code/src/MC_Kernels.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/code/src/MC_Kernels.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Kernels.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/code/src/MC_Kernels.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Helpers.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/code/src/MC_Helpers.cu.o: ../code/src/MC_Helpers.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_11) "Building CUDA object CMakeFiles/MC_Simulation.dir/code/src/MC_Helpers.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/code/src/MC_Helpers.cu -o CMakeFiles/MC_Simulation.dir/code/src/MC_Helpers.cu.o

CMakeFiles/MC_Simulation.dir/code/src/MC_Helpers.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/code/src/MC_Helpers.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Helpers.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/code/src/MC_Helpers.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_MLTissue.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/code/src/MC_MLTissue.cu.o: ../code/src/MC_MLTissue.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_12) "Building CUDA object CMakeFiles/MC_Simulation.dir/code/src/MC_MLTissue.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/code/src/MC_MLTissue.cu -o CMakeFiles/MC_Simulation.dir/code/src/MC_MLTissue.cu.o

CMakeFiles/MC_Simulation.dir/code/src/MC_MLTissue.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/code/src/MC_MLTissue.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_MLTissue.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/code/src/MC_MLTissue.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Simulation.cu.o: CMakeFiles/MC_Simulation.dir/flags.make
CMakeFiles/MC_Simulation.dir/code/src/MC_Simulation.cu.o: ../code/src/MC_Simulation.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_13) "Building CUDA object CMakeFiles/MC_Simulation.dir/code/src/MC_Simulation.cu.o"
	/usr/local/cuda-11.0/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/code/src/MC_Simulation.cu -o CMakeFiles/MC_Simulation.dir/code/src/MC_Simulation.cu.o

CMakeFiles/MC_Simulation.dir/code/src/MC_Simulation.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MC_Simulation.dir/code/src/MC_Simulation.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/MC_Simulation.dir/code/src/MC_Simulation.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MC_Simulation.dir/code/src/MC_Simulation.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

# Object files for target MC_Simulation
MC_Simulation_OBJECTS = \
"CMakeFiles/MC_Simulation.dir/main.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_RNG.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Point.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Vector.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Photon.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Path.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Tissue.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_FiberGenerator.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Math.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Kernels.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Helpers.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_MLTissue.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Simulation.cu.o"

# External object files for target MC_Simulation
MC_Simulation_EXTERNAL_OBJECTS =

CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/main.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/code/src/MC_RNG.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/code/src/MC_Point.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/code/src/MC_Vector.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/code/src/MC_Photon.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/code/src/MC_Path.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/code/src/MC_Tissue.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/code/src/MC_FiberGenerator.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/code/src/MC_Math.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/code/src/MC_Kernels.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/code/src/MC_Helpers.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/code/src/MC_MLTissue.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/code/src/MC_Simulation.cu.o
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/build.make
CMakeFiles/MC_Simulation.dir/cmake_device_link.o: CMakeFiles/MC_Simulation.dir/dlink.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_14) "Linking CUDA device code CMakeFiles/MC_Simulation.dir/cmake_device_link.o"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/MC_Simulation.dir/dlink.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/MC_Simulation.dir/build: CMakeFiles/MC_Simulation.dir/cmake_device_link.o

.PHONY : CMakeFiles/MC_Simulation.dir/build

# Object files for target MC_Simulation
MC_Simulation_OBJECTS = \
"CMakeFiles/MC_Simulation.dir/main.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_RNG.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Point.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Vector.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Photon.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Path.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Tissue.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_FiberGenerator.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Math.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Kernels.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Helpers.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_MLTissue.cu.o" \
"CMakeFiles/MC_Simulation.dir/code/src/MC_Simulation.cu.o"

# External object files for target MC_Simulation
MC_Simulation_EXTERNAL_OBJECTS =

MC_Simulation: CMakeFiles/MC_Simulation.dir/main.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/code/src/MC_RNG.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/code/src/MC_Point.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/code/src/MC_Vector.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/code/src/MC_Photon.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/code/src/MC_Path.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/code/src/MC_Tissue.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/code/src/MC_FiberGenerator.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/code/src/MC_Math.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/code/src/MC_Kernels.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/code/src/MC_Helpers.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/code/src/MC_MLTissue.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/code/src/MC_Simulation.cu.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/build.make
MC_Simulation: CMakeFiles/MC_Simulation.dir/cmake_device_link.o
MC_Simulation: CMakeFiles/MC_Simulation.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_15) "Linking CUDA executable MC_Simulation"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/MC_Simulation.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/MC_Simulation.dir/build: MC_Simulation

.PHONY : CMakeFiles/MC_Simulation.dir/build

CMakeFiles/MC_Simulation.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/MC_Simulation.dir/cmake_clean.cmake
.PHONY : CMakeFiles/MC_Simulation.dir/clean

CMakeFiles/MC_Simulation.dir/depend:
	cd /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug /home/mostafa/CLionProjects/Monte-Carlo-Simulation-of-Light-Propagation/Simulation/cmake-build-debug/CMakeFiles/MC_Simulation.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/MC_Simulation.dir/depend

