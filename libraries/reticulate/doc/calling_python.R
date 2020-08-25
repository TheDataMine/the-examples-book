## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## ---- eval=FALSE--------------------------------------------------------------
#  library(reticulate)
#  os <- import("os")
#  os$listdir(".")

## -----------------------------------------------------------------------------
#  difflib <- import("difflib")
#  difflib$ndiff(foo, bar)
#  
#  filecmp <- import("filecmp")
#  filecmp$cmp(dir1, dir2)

## -----------------------------------------------------------------------------
#  main <- import_main()
#  
#  builtins <- import_builtins()
#  builtins$print('foo')

## -----------------------------------------------------------------------------
#  source_python('add.py')
#  add(5, 10)

## -----------------------------------------------------------------------------
#  library(reticulate)
#  
#  py_run_file("script.py")
#  
#  py_run_string("x = 10")
#  
#  # access the python main module via the 'py' object
#  py$x

## -----------------------------------------------------------------------------
#  # import numpy and specify no automatic Python to R conversion
#  np <- import("numpy", convert = FALSE)
#  
#  # do some array manipulations with NumPy
#  a <- np$array(c(1:4))
#  sum <- a$cumsum()
#  
#  # convert to R explicitly at the end
#  py_to_r(sum)

## -----------------------------------------------------------------------------
#  py <- import_builtins()
#  with(py$open("output.txt", "w") %as% file, {
#    file$write("Hello, there!")
#  })

## -----------------------------------------------------------------------------
#  iterate(iter, print)

## -----------------------------------------------------------------------------
#  results <- iterate(iter)

## -----------------------------------------------------------------------------
#  a <- iterate(iter) # results are not empty
#  b <- iterate(iter) # results are empty since items have already been drained

## -----------------------------------------------------------------------------
#  while (TRUE) {
#    item <- iter_next(iter)
#    if (is.null(item))
#      break
#  }

## -----------------------------------------------------------------------------
#  while (TRUE) {
#    item <- iter_next(iter, completed = NA)
#    if (is.na(item))
#      break
#  }

## -----------------------------------------------------------------------------
#  # define a generator function
#  sequence_generator <-function(start) {
#    value <- start
#    function() {
#      value <<- value + 1
#      value
#    }
#  }
#  
#  # convert the function to a python iterator
#  iter <- py_iterator(sequence_generator(10))

## -----------------------------------------------------------------------------
#  sequence_generator <-function(start) {
#    value <- start
#    function() {
#      value <<- value + 1
#      if (value < 100)
#        value
#      else
#        NULL
#    }
#  }

