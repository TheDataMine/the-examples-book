# A vector is just a sequence for storing numbers,
#  or characters, strings, etc.

c(8, 5, 5, 2, 5, 4)

# the c command is used to combine values into a vector
?c

v <- c(8, 5, 5, 2, 5, 4)  # store vector into v
v   # check that v receives the values in that vector

# R has many vector-oriented operations,
# for instance, with addition:

v + 10
# what actually happens is that R converts the 10
# to a vector as well, namely, R does this:
v + c(10, 10, 10, 10, 10, 10)

# What about v + c(10) ?  Same effect
v + c(10)

# What if I add a vector of length 6 to a vector of length 2?
v + c(10, 20)
# R extends the shorter vector to be c(10, 20, 10, 20, 10, 20)
# this is called "recycling", when a vector automatically
# gets extended to match the need for some operation
v + c(10, 20, 10, 20, 10, 20)

v + c(10, 20, 30)
# this is the same as
v + c(10, 20, 30, 10, 20, 30)

# what if we add a vector of length 6 to a vector
# of length 4?
v + c(10, 20, 30, 40)
# now we get a warning, but R still does the operation
# R performs this:
v + c(10, 20, 30, 40, 10, 20)
# BUT R complains (with a warning) because it is guessing
# that is not what you wanted to do, since the shorter
# vector did not get extended an integer number of times
# it got extended just part way

# also get a warning, but R will do it, if we try this:
v + c(10, 20, 30, 40, 50)
# what did R do?
v + c(10, 20, 30, 40, 50, 10)

# finally, 
v + c(10, 20, 30, 40, 50, 60)
# everything goes as planned

# So in general, if we take, for instance
v
# of length 6, a vector, and add another vector,
# R will also extend the shorter vector,
# and R will only give a warning if the shorter vector
# is not extended an integer number of times

# this phenomenon of extending a vector to match the need
# is called "recycling".  We see it a LOT when using R.

