# continue to study randomly generated values and the resulting qqplots
# that let us see how two different distributions are related to each other

# This time we use Student t distribution
# which is important in mathematical statistics,
# but which we will probably not see in our probability theory course

?rt
# In our example, we will use Student t distribution with 5 degrees of freedom
# i.e., we will use df=5

# We should compare (naturally) to another kind of random variable
# with mean 0 and standard deviation sqrt(5/3)

qqplot( rnorm(1000, mean=0, sd=sqrt(5/3)), rt(1000, df=5) )
abline(0,1)   # line with y-int 0 and slope 1

# Notice that both distributions have 0 as the median
# As we move away from the median, say toward the right-hand side,
# we see that the distribution is more heavily skewed in the normal direction
# so that the normal random variables are headed away from the median faster
# but then as we get further out into the tail, the Student t numbers
# become more skewed, i.e., head away from the median faster

# Same phenomenon on the left-hand side too,
# i.e., moving to the left-hand side away from the median,
# the normal random variables are headed away from the median faster
# but after a certain point, as we head toward -infinity, 
# the Student t numbers are skewed closer to -infinity, i.e.,
# move away from the median faster

# This is just a process, something for your eyes to get used to.
# Let's compare to how the densities of the two distributions look
# i.e., let's look at the density f(x) for each distribution

# We can use dt and dnorm for this purpose

mypoints <- seq(-8,8,by=0.1)
t <- dt( mypoints, df=5)   # this shows how the density of Student t is shaped
n <- dnorm( mypoints, mean=0, sd=sqrt(5/3)) # this shows the density of a normal distribution

plot( mypoints, t, ylim=c(min(n,t), max(n,t)), col="red")
points( mypoints, n, col="blue")
# wrote Student t distribution in red
# and the normal distribution in blue

# Notice that the Student t distribution is slightly more compact near the median
# i.e., slightly more densely distributed near the median

# but it is also more skewed away from the median as we go into the tails

mypoints <- seq(0,8,by=0.1)
t <- dt( mypoints, df=5)   # this shows how the density of Student t is shaped
n <- dnorm( mypoints, mean=0, sd=sqrt(5/3)) # this shows the density of a normal distribution

plot( mypoints, t, ylim=c(min(n,t), max(n,t)), col="red")
points( mypoints, n, col="blue")



mypoints <- seq(3,8,by=0.1)
t <- dt( mypoints, df=5)   # this shows how the density of Student t is shaped
n <- dnorm( mypoints, mean=0, sd=sqrt(5/3)) # this shows the density of a normal distribution

plot( mypoints, t, ylim=c(min(n,t), max(n,t)), col="red")
points( mypoints, n, col="blue")




mypoints <- seq(5,20,by=0.1)
t <- dt( mypoints, df=5)   # this shows how the density of Student t is shaped
n <- dnorm( mypoints, mean=0, sd=sqrt(5/3)) # this shows the density of a normal distribution

plot( mypoints, t, ylim=c(min(n,t), max(n,t)), col="red")
points( mypoints, n, col="blue")



mypoints <- seq(10,20,by=0.1)
t <- dt( mypoints, df=5)   # this shows how the density of Student t is shaped
n <- dnorm( mypoints, mean=0, sd=sqrt(5/3)) # this shows the density of a normal distribution

plot( mypoints, t, ylim=c(min(n,t), max(n,t)), col="red")
points( mypoints, n, col="blue")




