DF <- read.csv("saturn03.240.A.CT_2012_06_PD0.csv")
# this reads the csv file into R's memory

class(DF)   # check that DF is a data.frame
dim(DF)     # check the dimension of the data.frame
head(DF)    # look at the first several rows of the data.frame

# convert the values in the 1st column of the data.frame to seconds
timevec <- strptime(DF[ ,1],  "%Y/%m/%d %H:%M:%S")
# see the first several values that result from the conversion
head(timevec)
# we can force these values to look numeric, in seconds given after January 1, 1970
head(as.numeric(timevec))
tail(as.numeric(timevec))

# read the salinity data from column 2 of the data.frame
salinity <- DF[ ,2]

# verify that timevec and salinity are both the same length
length(timevec)
length(salinity)

# make a plot of the salinity versus the time
plot(timevec, salinity)

# change the starting time and stopping time
starttime <- strptime("2012/06/09 00:00:00", "%Y/%m/%d %H:%M:%S")
stoptime <- strptime("2012/06/14 23:59:59", "%Y/%m/%d %H:%M:%S")

# make a plot of the salinity versus the time, between
# the start of the day on June 9, 2012 and the end of the day on June 14, 2012
plot(timevec[ timevec>starttime & timevec < stoptime],  salinity[ timevec>starttime & timevec < stoptime])
