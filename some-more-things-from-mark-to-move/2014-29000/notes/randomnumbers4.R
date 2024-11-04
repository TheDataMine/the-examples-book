# one more example of randomly generated numbers
# and qqplots

# suppose we generate 10000 random numbers that have exponential distributions
# with mean 1/60 i.e. rate=60
?rexp
v <- rexp(10000, rate=60)
# this gives a vector of 10000 exponential random variables with mean 1/60

w <- rexp(10000, rate=1)
# this gives 10000 exponentials with mean 1/1 = 1

qqplot(v,w)
abline(0,60)

# looks like line with y-int 0 and slope 60 is a good fit for
# where the points lie

# we could try again several times, to see if the fit still looks good


v <- rexp(10000, rate=60)
w <- rexp(10000, rate=1)
qqplot(v,w)
abline(0,60)

# We might guess, and indeed it is true, as we will see in STAT/MA 41600
# (our probability course) that W and 60*V have the same distribution

# in other words, if V is an exponential random variable with mean 1/60
# then 60*V has the same distribution as a random variable W that is
# exponentially distributed with mean 1.

# Example of how the qqplot points are generated:
# For instance, let's compute the 40th percentile for each:
qexp(0.40, rate=60)
qexp(0.40, rate=1)
# So we should expect to have a point at (v,w) = (0.0085, 0.51)
# because F(0.0085) = 0.40 for the v-vector
# and F(0.51) = 0.40 for the w-vector



