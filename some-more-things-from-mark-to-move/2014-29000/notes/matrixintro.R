# introduction to matrices

# a matrix is sort-of like a vector but in two dimensions instead of one

v <- c(3,1,4,1,5,9)
v[1]
v[3:6]

M <- matrix( c(2,1,7,9,3,18,4,0), nrow=2, ncol=4)
M
# we see that by default, the filling of the matrix is done column-by-column

?matrix
M <- matrix( c(2,1,7,9,3,18,4,0), nrow=2, ncol=4, byrow=TRUE)
M
# this causes the entries of the matrix to filled across the rows, i.e., row-by-row

# it is enough to just specify either
# the number of rows (nrow) or the number of columns (ncol)
M <- matrix( c(2,1,7,9,3,18,4,0), nrow=2, byrow=TRUE)
M

# what can we tell about the matrix, e.g., class
class(M)
dim(M)   # the dimension tells the number of rows, then the number of columns
length(M)  # total number of entries

# we can go and extract certain rows or columns of a matrix,
# in much the same way as we did with vectors

# e.g., we can extract the 1st, 2nd, 3rd columns, and store the result in a new matrix
mymatrix <- M[ ,1:3]
mymatrix

# the columns we extract do not have to be consecutive, e.g.,
# we could extract the 1st and 3rd columns only:
newmatrix <- M[ ,c(1,3)]
newmatrix

# NOTICE: we just left the specifications for the rows blank,
# which tells R we want all of the rows

# just like with vectors, we can use negative entries
# to say that we want to remove certain rows or columns
M
Mwithoutcolumn3 <- M[ , -3]  # this removes the 3rd column
M
Mwithoutcolumn3

# another example:
N <- matrix(1:24, nrow=6)
N
# to display just rows 2, 4, and 6 of N, we could write:
N[c(2,4,6), ]
# notice that we just left the column specifications for N blank this time

# we can look at some select rows and columns simultaneously:
# for instance, say we want the first 3 rows and the first 2 columns:
N[1:3, 1:2]
# or equivalently,
N[ c(1,2,3), c(1,2)]

# we can take a transpose of a matrix,
# i.e., shifts the roles of the rows and columns
N
t(N)

# we can also bind together rows or columns, to create a new matrix
N
cbind( N[,3], N[,4])
rbind( N[1, ], N[4, ], N[6, ])
# cbind and rbind are helpful in other circumstances too; these are handy functions





