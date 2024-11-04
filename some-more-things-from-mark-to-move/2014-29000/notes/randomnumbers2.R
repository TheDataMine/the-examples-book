# qqplot's: easy to understand and use,
# once we practice a little bit, and once we see some examples

# they compare where the quantiles of two different distributions occur
# so this gives us some information about how two distributions are skewed
# in the same ways or in different ways

# example: Let's compare how normally distributed random variables with
#          mean 0 and standard deviation 1 are distributed,
#          as compared to uniform random variables that are between -1 and 1

v <- rnorm(10000, mean=0, sd=1)
w <- runif(10000, min=-1, max=1)

qqplot(v,w)  # qqplot comparing the normals versus the uniforms
abline(0,1)  # line with y-intercept 0 and slope 1

# for example, if we look at the medians, i.e., at the 50th percentiles of each:
# F(v) = 0.50    # this occurs when v=0
# F(w) = 0.50    # this occurs when w=0
# we can check this with the qnorm and qunif functions:
qnorm( 0.50, mean=0, sd=1)
qunif( 0.50, min=-1, max=1)

# now let's check the 95th percentiles:
# F(v) = 0.95   # occurs when v=1.644854....
# F(w) = 0.95   # occurs when w=0.9
qnorm( 0.95, mean=0, sd=1)
qunif( 0.95, min=-1, max=1)

# now let's check the 90th percentiles:
# F(v) = 0.90   # occurs when v=1.281552....
# F(w) = 0.90   # occurs when w=0.8
qnorm( 0.90, mean=0, sd=1)
qunif( 0.90, min=-1, max=1)

# now let's check the 60th percentiles:
# F(v) = 0.60   # occurs when v=0.2533471....
# F(w) = 0.60   # occurs when w=0.2
qnorm( 0.60, mean=0, sd=1)
qunif( 0.60, min=-1, max=1)

# similarly we can compare other values, and
# we see all of them on the qqplot itself

# This plot shows us a few things.
# For instance, it shows us that in the right-hand tail, the
# normal distribution is skewed much further to the right
# than the uniform distribution.
# This makes sense, because the uniform distribution stops at 1 at the max
# and the normal distribution has a tail that slowly heads to infinity.

# If the two distributions had qqplot values that were on (or near) the line drawn
# then the distributions would look approximately the same

# On the left-hand side, where the small values of the distribution occur
# we see that the uniforms are capped at -1 as the smallest possible values
# but the normal random variables can be distributed towards -infinity
# therefore the qqplot branches toward the normal side of things, as the
# CDF values we consider get small.

# Again, if the values were near the line drawn, the two distributions
# would be about the same.

# JUST FOR COMPARISON:
# Let's suppose we make a qqplot of two vectors drawn from the same distribution:

# these are still both randomly generated vectors; they are not the same:
u <- rnorm(200, mean=5, sd=3)
v <- rnorm(200, mean=5, sd=3)
head(u)
head(v)
qqplot(u,v)
abline(0,1)

# want them closer to the line?  Just generate more values,
# and the fit will be even better:
u <- rnorm(2000, mean=5, sd=3)
v <- rnorm(2000, mean=5, sd=3)
head(u)
head(v)
qqplot(u,v)
abline(0,1)


# want them closer to the line?  Just generate more values,
# and the fit will be even better:
u <- rnorm(20000, mean=5, sd=3)
v <- rnorm(20000, mean=5, sd=3)
head(u)
head(v)
qqplot(u,v)
abline(0,1)


