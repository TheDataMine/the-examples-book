# examples with arrays

# first we note that vectors are 1-dimensional
# matrices are 2-dimensional
# arrays are the generalization of that,
# can be 1 or more dimensions

# for instance, suppose we want a 4-dimensional array
# suppose we want to put the numbers 1 through 240 in it
# and suppose we want it to be 4 by 10 by 3 by 2 for the dimensions

A <- array( 1:240, dim=c(4,10,3,2) )
A
# the filling is done progressively, dimension by dimension

# many replacements should work in an intuitive way,
# once you just relate them to have things work for matrices
A[ , , , 1] <- 57
A

# arrays actually come up in practice too
?iris3
# iris3 is just a 3-dimensional version of the iris data

head(iris)
# first 50 entries of iris were setosa
# next 50 entries were versicolor
# next 50 entries were virginica
# the iris data set is saved as a 150 by 5 matrix (2 dimensions)

iris3
# this is a 50 by 4 by 3 array

# e.g., this is just the setosa data
iris3[ , , 1]

# both iris and iris3 are storing 150*4 = 600 measurements of flower data altogether
# these are the sepal lengths for all of iris3
iris3[ ,1, ]
head(iris3[ ,1, ])

# these are the analogous sepal lengths from iris (just showing the heads of each)
iris[1:6, ]
iris[51:56, ]
iris[101:106, ]

