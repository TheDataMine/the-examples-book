?rnorm  # used to generate random numbers with a normal distribution
?runif  # used to generate random numbers with a continuous uniform distribution
?rgeom  # used to generate random numbers with a discrete geometric distribution
        # notice that this is the geometric number of losses distribution
?rexp   # used to generate random numbers with an exponential distribution
# etc., etc

# remember to use help.search if you cannot find the one that you want.

?rnorm
# to generate 20 numbers with a normal distribution, we use 0 for the mean,
# and 1 for the standard deviation:
rnorm(20, 0, 1)

?runif
# or we could generate 20 random numbers with a uniform distribution:
# we use min of 0 and a max of 2
runif(20, 0, 2)



