# lookup the function name for generating
# normally-distributed random values
help.search("normal")

v <- rnorm(100)

# can take sums, means, etc., as we did with 
# uniformly distributed random numbers
sum(v)
mean(v)

# If Y is normally distributed, then X = exp(Y)
# is log-normally distributed

# check that this makes sense if we test:

# first lookup the function for log-normal values:
help.search("normal")
# the mean of 100 log-normal random variables:
mean(rlnorm(1000000))

#Now take 1 million standard normal values, and
# take e raised to the power of each one:
mean(exp(rnorm(1000000)))

# notice that R went term by term, taking powers of e.
# R did NOT just take a mean, and then raise to the
# power of e at the end, because that doesn't give
# us the kind of computation we want; i.e., this
# would be the wrong kind of result:
exp(mean(rnorm(1000000)))

# other things we can do with vectors:
v <- rnorm(10)
v

# if we want to know which are positive, which are negative:
sign(v)
# this gives +1 for positive values,
# and gives -1 for negative values
# it gives 0 for values that are exactly 0

# we can get the range of values:
range(v)
# or we can do this piece-by-piece:
min(v)
max(v)

# we can sort in R very easily, e.g.,:
sort(v)
?sort
# if we want the values to be decreasing:
sort(v, decreasing=TRUE)
# or we could have written:
rev(sort(v))
# i.e., we could have sorted and then reversed the order.

# we also have a parallel min and a parallel max:
?pmax
a <- rnorm(5)
b <- rnorm(5)
c <- rnorm(5)
a
b
c
a; b; c

# find the max, piece by piece:
pmax( a, b, c)
# or we could find the min, piece by piece:
pmin( a,b,c )

# two more examples:
# we can absolute values, term by term:
abs(v)

# we can square roots, term by term:
sqrt(abs(v))

# we can trig functions, piece by piece:
sin(v)
cos(v)
tan(v)
