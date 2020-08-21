## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## ---- eval = FALSE------------------------------------------------------------
#  install_scipy <- function(method = "auto", conda = "auto") {
#    reticulate::py_install("scipy", method = method, conda = conda)
#  }

## -----------------------------------------------------------------------------
#  # python 'scipy' module I want to use in my package
#  scipy <- NULL
#  
#  .onLoad <- function(libname, pkgname) {
#    # delay load foo module (will only be loaded when accessed via $)
#    scipy <<- import("scipy", delay_load = TRUE)
#  }

## -----------------------------------------------------------------------------
#  # helper function to skip tests if we don't have the 'foo' module
#  skip_if_no_scipy <- function() {
#    have_scipy <- py_module_available("scipy")
#    if (!have_scipy)
#      skip("scipy not available for testing")
#  }
#  
#  # then call this function from all of your tests
#  test_that("Things work as expected", {
#    skip_if_no_scipy()
#    # test code here...
#  })

## ----eval=FALSE---------------------------------------------------------------
#  method.MyModule.MyPythonClass <- function(x, y, ...) {
#    if (py_is_null_xptr(x))
#      # whatever is appropriate
#    else
#      # interact with the object
#  }

## ----eval=FALSE---------------------------------------------------------------
#  #' @importFrom reticulate py_str
#  #' @export
#  py_str.MyModule.MyPythonClass <- function(object, ...) {
#    # interact with the object to generate the string
#  }

## -----------------------------------------------------------------------------
#  library(reticulate)
#  
#  # [convert = TRUE] => convert Python objects to R when appropriate
#  sys <- import("sys", convert = TRUE)
#  class(sys$path)
#  # [1] "character"
#  
#  # [convert = FALSE] => always return Python objects
#  sys <- import("sys", convert = FALSE)
#  class(sys$path)
#  # [1] "python.builtin.list" "python.builtin.object"

## ----eval=FALSE---------------------------------------------------------------
#  # suppose 'make_python_object()' creates a Python object
#  # from R objects of class 'my_r_object'.
#  r_to_py.my_r_object <- function(x, convert) {
#    object <- make_python_object(x)
#    assign("convert", convert, envir = object)
#    object
#  }

