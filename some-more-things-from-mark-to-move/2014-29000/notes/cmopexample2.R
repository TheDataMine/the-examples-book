DF <- read.csv("saturn03.240.A.CT_2012_06_PD0.csv")
# this reads the csv file into R's memory

# convert the values in the 1st column of the data.frame to seconds
timevec <- strptime(DF[ ,1],  "%Y/%m/%d %H:%M:%S")

# read the salinity data from column 2 of the data.frame
salinity <- DF[ ,2]

head(DF)
temperature <- DF[ ,4]

range(temperature)   # find the range on the temperature; the 546 maximum looks strange

# sometimes plotting the values gives us some insight:
plot(temperature)
# check: just 1 value of temperature above 500
temperature[temperature > 500]
# no temperature values between (say) 25 and 500
temperature[temperature <= 500 & temperature > 25]
# so we will cut off the value at 546 and just use values from 25 and below

# change the starting time and stopping time
starttime <- strptime("2012/06/07 00:00:00", "%Y/%m/%d %H:%M:%S")
stoptime <- strptime("2012/06/07 23:59:59", "%Y/%m/%d %H:%M:%S")

# now let's plot the temperature versus the salinity data
plot( temperature[temperature < 25 & timevec > starttime & timevec < stoptime],
         salinity[temperature < 25 & timevec > starttime & timevec < stoptime] )

