## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## -----------------------------------------------------------------------------
#  library(reticulate)
#  
#  # create a new environment
#  conda_create("r-reticulate")
#  
#  # install SciPy
#  conda_install("r-reticulate", "scipy")
#  
#  # import SciPy (it will be automatically discovered in "r-reticulate")
#  scipy <- import("scipy")

## -----------------------------------------------------------------------------
#  library(reticulate)
#  
#  # indicate that we want to use a specific condaenv
#  use_condaenv("r-reticulate")
#  
#  # import SciPy (will use "r-reticulate" as per call to use_condaenv)
#  scipy <- import("scipy")

## -----------------------------------------------------------------------------
#  library(reticulate)
#  
#  # create a new environment
#  virtualenv_create("r-reticulate")
#  
#  # install SciPy
#  virtualenv_install("r-reticulate", "scipy")
#  
#  # import SciPy (it will be automatically discovered in "r-reticulate")
#  scipy <- import("scipy")

## -----------------------------------------------------------------------------
#  library(reticulate)
#  
#  # indicate that we want to use a specific virtualenv
#  use_virtualenv("r-reticulate")
#  
#  # import SciPy (will use "r-reticulate" as per call to use_virtualenv)
#  scipy <- import("scipy")

