# one more example with matrices

?state.x77
head(state.x77)
class(state.x77)   # this data set is a matrix
dim(state.x77)     # 50 rows, 8 columns

M <- state.x77
mymatrix <- M[ , c(1,2,8)]
head(mymatrix)

# this has the same effect, namely, to store the 1st, 2nd, 8th columns
# into a new matrix called mymatrix
mymatrix <- M[ ,c("Population", "Income", "Area")]

# we can (for instance) multiply all of the values in the 2nd column by 10
mymatrix[ ,2] <- mymatrix[ ,2]*10
mymatrix

# remember: matrices always store the same kind of data in every column (e.g., all numeric data)
# whereas data.frames can store different types of data in different columns
# both are similar in that they both have rectangular shapes, always



