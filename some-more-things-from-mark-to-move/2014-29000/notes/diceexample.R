# generates 100 random numbers, each between 0 and 1
v <- runif(100)

# these numbers are random, between 0 and 6
# notice that R recycles the lone 6 into
# a new vector c(6,6,6,6,.....,6)
# i.e., R makes the 6 into a vector of length 100 of 6's:
6*v

# same effect:
rep(6, 100) * v

# round all of the numbers up, now we have 100 dice rolls:
ceiling(6*v)

# could take the sum of the 100 dice rolls:
sum( ceiling(6*v) )
# could find out how many dice rolls you have:
length( ceiling(6*v) )

# this is a long way to find the average of the 100 rolls:
sum( ceiling(6*v) ) / length( ceiling(6*v) )

# a shorter way is:
mean( ceiling(6*v) )

# variance:
var( ceiling(6*v) )

# summarize the way that the 100 rolls are distributed:
summary( ceiling(6*v) )

# TRUE's for the rolls that are 1, FALSE's otherwise:
ceiling(6*v) == 1

# this tells us how many 1's we got:
sum(ceiling(6*v) == 1)

# similarly we could find out how many of the other values:
sum(ceiling(6*v) == 2)
sum(ceiling(6*v) == 3)
sum(ceiling(6*v) == 4)
sum(ceiling(6*v) == 5)
sum(ceiling(6*v) == 6)

# much easier is to use the table function:
table( ceiling(6*v) )
