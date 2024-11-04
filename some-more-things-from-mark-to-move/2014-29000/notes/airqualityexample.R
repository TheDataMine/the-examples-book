?airquality
head(airquality)

# find the average wind (mph) per month
tapply( airquality$Wind, airquality$Month, mean)

# find the average temperature, again by month:
tapply( airquality$Temp, airquality$Month, mean)

# find the average Ozone, again by month:
tapply( airquality$Ozone, airquality$Month, mean)
# something is broken, why?
airquality$Ozone
# we need to use the na.rm=T parameters, which is saying YES we want to remove the NA's.
tapply( airquality$Ozone, airquality$Month, mean, na.rm=T)

# we would have had the same problem by hand:
mean(airquality$Ozone[airquality$Month == 7])
mean(airquality$Ozone[airquality$Month == 7], na.rm=T)
