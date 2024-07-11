//
// Created by Bruno Schilling on 29.05.24.
//

// #define PYBIND11_DETAILED_ERROR_MESSAGES

#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>

#include <packagetest.h>


namespace py = pybind11;


PYBIND11_MODULE(packagetest_cpp, m) {
  m.doc() = "Some package test";

  m.def("foo", &foo, "just a foo function");
}
