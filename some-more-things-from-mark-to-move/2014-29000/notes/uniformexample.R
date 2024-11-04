# say we forget the name of a command in R
help.search("uni")
help.search("unif")

# if we remember the name of the function,
# we can search for the help menu directly, e.g.:
?runif

# this will give us an error, if I do not specify n:
runif()
# this will work properly:
runif(10)

# or we could change the min and max,
# this will generate 10 numbers between 2 and 17:
runif(10, 2, 17)

# why should we avoid (in general!) for loops in R
# in almost all cases?  R is slow (generally) at for loops:

# slower:
system.time(for (i in 1:1000000) runif(1))

# faster:
system.time(v <- runif(1000000))

# in terms of user time, the vectorized version is
# approximately 30 times faster
# in general, vectorized operations (not for loops)
# work much, much faster in R
# so try to think about vectorized operations,
# to put your mind into that way of thinking.
