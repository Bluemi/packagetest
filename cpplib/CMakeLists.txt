cmake_minimum_required(VERSION 3.19)

# Only interpret if() arguments as variables or keywords when unquoted. More
# details run "cmake --help-policy CMP0054"
# cmake_policy(SET CMP0054 NEW)

project(
  packagetest
  DESCRIPTION
	  "Some packaging tests"
  VERSION 0.0.1
  LANGUAGES CXX
  )

option(FORCE_AVX2 "compile for avx2 support. Otherwise compile for this machine." OFF)

# https://cmake.org/cmake/help/latest/prop_tgt/CXX_STANDARD.html
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(compile-options INTERFACE)
target_compile_features(compile-options INTERFACE cxx_std_20)
target_compile_definitions(compile-options INTERFACE $<$<PLATFORM_ID:Windows>:NOMINMAX>)

# detecting CPU instruction support
# https://github.com/lemire/FastPFor/blob/master/CMakeLists.txt
if (APPLE AND CMAKE_SYSTEM_PROCESSOR STREQUAL "arm64")
  message(WARNING "You are compiling on an Apple M chip. At the moment does not support ARM optimizations, so using will be slow!")
endif()

  message(NOTICE "--- Compiling for avx2, ignoring native optimizations. ---")
  # setup compiler flags
  if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    target_compile_options(
      compile-options
      INTERFACE -O2
                -mavx2
                -mfma
                -fpic
                -fopenmp)
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")
    target_compile_options(
      compile-options
      INTERFACE -O2
                -mavx2
                -mfma
                -O2
                -fpic)
  elseif(MSVC)
    # warning level 4 (show all)
    target_compile_options(compile-options INTERFACE /W4)

    option(KEEP_DEBUG_SYMBOLS "Whether to compile with /Zi and /DEBUG" off)
    if(KEEP_DEBUG_SYMBOLS)
      target_compile_options(compile-options INTERFACE /Zi)
      target_link_options(compile-options INTERFACE /DEBUG)
    endif()

    # always use AVX2
    target_compile_options(compile-options INTERFACE /arch:AVX2)

    # disable string optimizations and function level linking
    # https://stackoverflow.com/questions/5063334/what-is-the-difference-between-the-ox-and-o2-compiler-options
    target_compile_options(compile-options INTERFACE $<$<CONFIG:Release>:/Ox>)
  else()
    message(WARNING "Unknown compiler for AVX2 Build: ${CMAKE_CXX_COMPILER_ID}")
  endif()

message("C++ compiler flags: ${CMAKE_CXX_FLAGS}")
message("C++ compiler flags release: ${CMAKE_CXX_FLAGS_RELEASE}")

add_subdirectory(packagetest)
