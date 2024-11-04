install.packages("ncdf")
library(ncdf)

# Example of how the paste function works:

myfolder <- "saturn03.240.A.CT"
mydate <- "201206"
# Now we can paste together the location where the June 2012 data is stored:
paste("http://amb6400b.stccmop.org:8080/thredds/dodsC/preliminary_data/saturn03/", myfolder, "/", mydate, ".nc", sep="")

# This was the SAME data we looked at, in Project 2, for the SATURN data 
#   (temperature/conductivity/salinity data)

# We can see all of the months for this data for these 3 parameters in this directory: 
# Take a look in Firefox; give it a look!
#   http://amb6400b.stccmop.org:8080/thredds/dodsC/preliminary_data/saturn03/saturn03.240.A.CT/
# There is one file per month, from August 2009 through September 2014 (62 months total).
# So far, we have only looked at the June 2012 data.
  
# NOW we prepare to look at all 62 months of data at once.
# We do not want to have to save 62 separate files.
# So we made some tools to make this easier.

# Later (in Project 5) we will look at other parameters too;
#   you can see the other data available by looking here:
#   http://amb6400b.stccmop.org:8080/thredds/dodsC/preliminary_data/saturn03/

# General function for getting the parameter names from SATURN 03,
# in a given folder (myfolder), for a given date (mydate)
  
getparameternames <- function(myfolder, mydate) {
  mync <- open.ncdf( paste("http://amb6400b.stccmop.org:8080/thredds/dodsC/preliminary_data/saturn03/", myfolder, "/", mydate, ".nc", sep="") )
  mycount <- mync$nvars
  mynames <- sapply( c(1:mycount), function(x) {mync$var[[x]]$name} )
  close.ncdf(mync)
  mynames
}
  
# General function for getting the data from SATURN 03,
# in a given folder (myfolder), for a given date (mydate), for a given parameter (myparameter)
  
getdata <- function(myfolder, mydate, myparameter) {
  mync <- open.ncdf( paste("http://amb6400b.stccmop.org:8080/thredds/dodsC/preliminary_data/saturn03/", myfolder, "/", mydate, ".nc", sep="") )
  myvec <- get.var.ncdf(mync, mync$var[[myparameter]])
  close.ncdf(mync)
  myvec
}

# General function for getting the times from SATURN 03,
# in a given folder (myfolder), for a given date (mydate)

gettimes <- function(myfolder, mydate) {
  mync <- open.ncdf( paste("http://amb6400b.stccmop.org:8080/thredds/dodsC/preliminary_data/saturn03/", myfolder, "/", mydate, ".nc", sep="") )
  mytimes <- get.var.ncdf(mync,"time")
  close.ncdf(mync)
  mytimes
}

# Example of getting the parameter names for the June 2012 data:

getparameternames("saturn03.240.A.CT", "201206")

# temperature is parameter 1
# electrical conductivity data is parameter 2
# salinity data is parameter 3

# reading in the June 2012 data from the csv file (as in our earlier project):

DF <- read.csv("http://llc.stat.purdue.edu/2014/29000/projects/saturn03.240.A.CT_2012_06_PD0.csv")

# We retrieve one month of temperature data (which is parameter 1), from June 2012:
resultvec <- getdata("saturn03.240.A.CT", "201206", 1)
# We check the first few values, and the range of values:
head(resultvec)
range(resultvec)

# Now we compare to the temperature data from the csv file (as we did it in the past)
head(DF$water_temperature)
range(DF$water_temperature)

# They are very similar, just differing in the number of digits of accuracy.
range(DF$water_temperature - resultvec)
# They are only (at most) 5*10^(-4) to -5*10^(-4) apart.

# They do both contain the same number of data points:
length(DF$water_temperature)
length(resultvec)

# Here is a way to generate the months and years from 200908 to 201409
# We first make a list of the years:
rep(2009:2014,each=12)
# and a list of the months:
rep(sprintf("%02d", 1:12), 6)
# do you see how this works?  sprintf("%02d", 1:12)  just prints the months with a 2-digit format

# and then we paste these together, with sep="" so that we don't get any extra spaces:
v <- paste( rep(2009:2014,each=12),  rep(sprintf("%02d", 1:12), 6), sep="" )
v

# Finally, we throw away the months Oct, Nov, Dec 2014
v <- v[-(70:72)]
# and we throw away Jan through July 2009:
v <- v[-(1:7)]
# So here are the 62 months we want to analyze:
v

# We get the name data for all 62 months for all 3 variables:
namematrix <- mapply( FUN=getparameternames, myfolder="saturn03.240.A.CT", mydate=v, USE.NAMES=FALSE)
# This is a matrix:
class(namematrix)
# with 3 rows and 62 columns:
dim(namematrix)
# This shows that the first parameter is always temperature:
namematrix[1, ]
# and the second is always electrical conductivity
namematrix[2, ]
# and the third is always salinity
namematrix[3, ]

# Now we get the actual temperature data itself (which is parameter 1), for all 62 months.
# [[ NOTE: We could do similar things for parameters 2 and 3,
#          i.e., for the electrical conductivity data or the salinity data. ]]

myresults <- mapply(FUN=getdata, myfolder="saturn03.240.A.CT", mydate=v, myparameter=1, USE.NAMES=FALSE)
# this gives us a list of the month-by-month temperature data, which we called "myresults"
class(myresults)
# the length is 62 because we have 62 months, and each month has a different number of data points
length(myresults)

# We unlist the data from the list, and reassemble it into a vector using the c function
bigvec <- c(unlist(myresults))
# it is now a numeric vector:
class(bigvec)
# here are the first few values:
head(bigvec)
# There are 4734307 data points total (as opposed to just 202702 data points in the June 2012 data)
length(bigvec)

# We get the time data for June 2012:
t <- gettimes("saturn03.240.A.CT", "201206")
# It naturally comes in the form of seconds:
head(t)
# We can convert it to a readable date format, e.g., as follows:
newv <- format(as.POSIXct(t, origin="1970-01-01"), tz="UTC+8:00")
# We check the start and the end, to make sure that these really go from
# the start of June 2012 to the end of June 2012:
head(newv)
tail(newv)

# Now we get the times for all 62 months:

mytimes <- mapply(FUN=gettimes, myfolder="saturn03.240.A.CT", mydate=v, USE.NAMES=FALSE)
# the results again come back to us as a list:
class(mytimes)
# the length is 62 because we have 62 months, and each month has a different number of data points
length(mytimes)

# We unlist the data from the list, and reassemble it into a vector using the c function
timevec <- c(unlist(mytimes))
class(timevec)
head(timevec)

# We can convert this whole vector of times into a readable format as follows:
newtimevec <- format(as.POSIXct(timevec, origin="1970-01-01"), tz="UTC+8:00" )
head(newtimevec)
tail(newtimevec)
