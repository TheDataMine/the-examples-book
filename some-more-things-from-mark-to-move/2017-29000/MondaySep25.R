# For a quick example about the tapply function,
# we can read in the 2008 airline data
myDF <- read.csv("/scratch/scholar/m/mdw/proj1/pizza/2008.csv")

# It is worthwhile to check the dimension of the data.frame
dim(myDF)
# and the head of a couple columns.
head(myDF$DepDelay)
head(myDF$Origin)

# Now we calculate the average DepDelay for each origin airport.
tapply(myDF$DepDelay, myDF$Origin, mean, na.rm=T)

# and the average DepDelay for each airplane (i.e., for each tailnum)
tapply(myDF$DepDelay, myDF$TailNum, max, na.rm=T)

# When using the tapply function, it is worthwhile to make sure
# that the two vectors have the same length!
length(myDF$DepDelay)
length(myDF$TailNum)

# It is possible to group the data according to more than 1 variable.
# For instance, here we calculate the average DepDelay
# for each origin-to-destination flight path.
# We use a "list" to group together 2 variables for splitting the data.
myresults <- tapply(myDF$DepDelay, list(myDF$Origin,myDF$Dest), mean, na.rm=T)
# As a result, we get a 2-dimensional matrix
myresults
# Many of the results are NA because there is no available flight path
# on many of the origin-to-destination routes.

# The results are named according to the rows (for the origins)
# and the columns (for the destinations)
myresults["IND","ORD"]
# We can even ask for several rows and several columns at once.
myresults[c("IND","ORD","CVG","MDW"),c("IND","ORD","CVG","MDW")]
