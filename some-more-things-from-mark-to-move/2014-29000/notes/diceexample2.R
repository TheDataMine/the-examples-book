v <- ceiling(runif(100,0,6))

v

# how many die rolls of each type?
table(v)
# there are 100 altogether, of course:
sum(table(v))

# another way to make the table command:
tapply(v, v, length)

# suppose that we call results 1,2,3 as "low" results
# and results 4,5,6 as "high" results,
# and we want to know how many of each type,
# without having to add them up ourselves:
tapply(v, cut(v,breaks=c(0,3,6)), length)
# this seems right, if we check by hand: 12+15+21=48  19+17+16=52

tapply(v, cut(v,breaks=c(0,3,6)), mean)
# the average in the first group is around 2,
# the average in the second group is around 5

# if we made v much longer, the averages would closer and closer to 2 and 5
v <- ceiling(runif(10000000,0,6))
tapply(v, cut(v,breaks=c(0,3,6)), length)
tapply(v, cut(v,breaks=c(0,3,6)), mean)


