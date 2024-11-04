# more examples with matrices

M <- matrix( ceiling(6*runif(60)), nrow=12)
M

# we can give the columns and the rows some names
dimnames(M) <- list( c("A","B","C","D","E","F","G","H","I","J","K","L"), c("a","b","c","d","e"))
M

# one nice thing is that now you can refer to the rows and columns by their names
M[ c("D","E","F"), c("a","c","e")]

# no need to just use one-letter names either
dimnames(M) <- list( c("A","B","C","D","E","F","G","H","I","J","K","L"), c("pizza","bob","cat","dog","edward"))
M

M[ , c("cat","dog")]

# we can turn a matrix back into a vector using as.vector
?as.vector
M
as.vector(M)
class(as.vector(M))
length(as.vector(M))
vec <- as.vector(M)
# now we can treat vec like any other vector of length 60 and work with it

# we can replace entries of a matrix pretty easily
M
# double the entries in columns 4 and 5
M[ ,c(4,5)] <- M[ ,c(4,5)]*2
M
# change the entries in rows 6, 10, 11, 12 to all be values of 37
M[ c(6,10,11,12), ] <- 37   # the 37 will be recycled to be long enough
M

# let us replace the entries in columns 1 through 3 with the numbers 1 to 36 respectively
M[ , c(1,2,3)] <- 1:36
M





