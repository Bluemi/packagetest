# python-bindings/CMakeLists.txt
cmake_minimum_required(VERSION 3.19)
project(packagetest_cpp)

# Ensure python: This is necessary to build correctly
find_package(Python REQUIRED COMPONENTS Interpreter Development.Module)
message(STATUS "Python executable: ${Python_EXECUTABLE}")

# Add pybind11
find_package(pybind11 CONFIG REQUIRED)

# Add cpp-packagetest
add_subdirectory(${CMAKE_SOURCE_DIR}/cpplib/)
pybind11_add_module(packagetest_cpp src/packagetest_cpp/packagetest_cpp.cpp)

# Specify the include directories
include_directories(${CMAKE_SOURCE_DIR}/cpplib/packagetest/include)

target_link_libraries(packagetest_cpp PRIVATE compile-options)
