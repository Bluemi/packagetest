cmake_minimum_required (VERSION 3.19)

project(packagetest)

# setup the package test
# http://mariobadr.com/creating-a-header-only-library-with-cmake.html
add_library(PACKAGE_TEST INTERFACE)
target_include_directories(PACKAGE_TEST INTERFACE ${PROJECT_SOURCE_DIR}/include)
target_compile_features(PACKAGE_TEST INTERFACE cxx_std_20)
