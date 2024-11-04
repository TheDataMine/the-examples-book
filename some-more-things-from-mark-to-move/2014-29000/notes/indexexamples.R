x <- c(3, 1, 4, 1, 5, 9, NA, -3, 5.7, NA, 19)
y <- c(5, 1, 4, 19, 3, 6, NA, 5, 4.2, 5.9, 3)

# check whether two vectors are equal, component by component
x == y

# check within a vector, e.g., using thresholds,
x > 3
x >= 3

# select only the members of a vector that satisfy
# some TRUE's (in a index vector of TRUE's and FALSE's)
x[x > 3]
# can also look at other vectors, who have TRUE's in
# certain coordinates, which might arise from other vectors!
y[x > 3]

# to deal with the NA's we have other functions, e.g.,
# we can use is.na
is.na(x)
x[is.na(x)]
# I can find the values of x that are not NA's
x[!is.na(x)]

# There are four ways to index a vector:

# 1. Logical
length(x)
# length of x is 11.  I can use any vector of length 11
# filled with TRUE's and FALSE's, to get values from x

# elements of x that are bigger than 3
x>3
x[x>3]

# first six elements of x
c(rep(TRUE,times=6), rep(FALSE,times=5))
x[c(rep(TRUE,times=6), rep(FALSE,times=5))]

# find all values of x that are bigger than 1
# and also less than 7
x > 1 & x < 7
x[x > 1 & x < 7]
x[x > 1 & x < 7 & !is.na(x)]

# 2. Directly type the indices you want, e.g.,
# get the 4th and 7th values of x
x[c(4,7)]
# or the entries from the 7th through the 11th
x[7:11]

# 3. Use negative indices, which means to remove
# specified values of x, for instance
# remove the first 3 values of x
x[c(-1,-2,-3)]
# or just remove the first element
x[-1]
# or just remove the last element
x[-length(x)]

# 4. name your vector, using the names function,
# for instance,
countycounts <- c(92,102,88,83,72)
names(countycounts) <- c("Indiana","Illinois","Ohio","Michigan","Wisconsin")
# now I can still refer to element of countycounts
# with the schemes above, e.g.,
countycounts[3]
countycounts[c(1,2)]
countycounts[-4]
# you can use the names vector as indices:
countycounts[c("Indiana","Wisconsin")]

# it is helpful, by the way, to see that such a vector
# even with names included, is still just a vector
class(countycounts)
# i.e., we still just have a vector of numeric values
