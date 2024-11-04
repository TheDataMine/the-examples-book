# Let's take an in-depth look at the seq function
# it is just a fancier version of the colon
1:10
10:3
10:-7

# help documentation:
?seq

# seq(1, 10)  this means from 1 to 10, just like 1:10
seq(1,10)
seq(1,41)

# with the "by" parameter, we take steps by size 5 not 1:
seq(1, 41, by=5)
# since seq only has one parameter that starts with "b",
# we could (if we are in a hurry or lazy) just write b:
seq(1, 41, b=5)

# in fact, since "by" is the 3rd parameter, we do not
# actually even need to give it a label:
seq(1, 41, 5)

# if we want the length explicitly to be 5:
seq(1, 41, length=5)
# or shorter:
seq(1, 41, len=5)
# even shorter:
seq(1, 41, l=5)

# what about along.with?
# R will make a sequence as long as another (given) vector:
y <- c(7, 10, 2, 2, 19)
# R gives a sequence from 1 to 41 with length the same as y:
seq(1, 41, along.with=y)

# R can also give sequences with step sizes
# that are not necessarily integers:
seq(1, 41, by=2.5)

# R cares more about the specified step size
# than it does about where the seq ends:
seq(1, 41, by=7)

# R will assume that you want to go up by 1's
#if you do not specify
seq(1, length=10)
seq(1, along.with=y)

seq(1, by=3, along.with=y)
# we could switch the order of the parameters
# since we are being careful to name them:
seq(1, along.with=y, by=3)
# or if we name the first parameter as from=1, then
seq(along.with=y, by=3, from=1)
