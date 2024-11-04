
# first create a vector x of length 10
x <- rnorm(10)

# then insert NA after position 2 into x, save over old x
x <- append(x, NA, 2)

# check that x now has length 11 instead of 10:
x

x <- append(x, NA, 7)
# now x has length 12:
x

# what happens now if we try to sum the values of x?
sum(x)
# R does not know the sum, because some values are unknown.
# we could choose to ignore the NA's as follows:
sum(x, na.rm=TRUE)

# similarly for the range of values in x:
range(x)

# but R will be able to find the range if we ignore NA's:
range(x, na.rm=TRUE)

# this is given, for instance, in the help menus:
?range
?sum
