# The subset function is helpful for specifying
# certain rows of a data.frame that we want to see,
# because they meet certain conditions.

# for instance, we can build a data.frame from the
# airquality data.frame, which shows only the rows
# for which the Temp column has values that are 66, 68, 70, or 72.
subset(airquality, subset=Temp %in% c(66,68,70,72) )

# similarly, we could further restrict the data.frame to
# have those Temp values and also Ozone exactly 30
subset(airquality, subset=Temp %in% c(66,68,70,72) & Ozone==30 )

# or (alternatively) Ozone > 30
subset(airquality, subset=Temp %in% c(66,68,70,72) & Ozone>30 )

# or (alternatively) Ozone < 20
subset(airquality, subset=Temp %in% c(66,68,70,72) & Ozone<20 )

# or (alternatively) Ozone strictly between 20 and 30
# and we also added the select parameter, which means that the
# data.frame that we get will only have the selected columns,
# in this case, we are choosing to only include the Ozone, Wind, and Temp
subset(airquality, subset=Temp %in% c(66,68,70,72) & Ozone>20 & Ozone<30, select=c(Ozone, Wind, Temp) )

# Taking a look at the UScereal data set,
# we could make a new data.frame that shows only the rows
# which have vitamins equal to none or to 100%
library(MASS)
subset(UScereal, subset=vitamins %in% c("none","100%") )

# We could also make the resulting data.frame only have select columns,
# for instance, here we can restrict to calories, fibre, sugars, vitamins.
subset(UScereal, subset=vitamins %in% c("none","100%"), select=c(calories, fibre, sugars, vitamins) )
