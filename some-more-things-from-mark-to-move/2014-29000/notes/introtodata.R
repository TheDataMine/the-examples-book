# R has some build-in data sets
data()

# for instance, there is a data set on carbon dioxide
co2
?co2

length(co2)

# we can treat this time series just like a vector
range(co2)

# find values above 350
co2[co2 > 350]
# find values between 350 and 355
co2[co2 > 350 & co2 < 355]
# find values below 320 or above 360
co2[co2 < 320 | co2 > 360]
# find values below 315 or above 363
co2[co2 < 315 | co2 > 363]
# find values above 340
co2[co2 > 340]
# find values below 340
co2[co2 <= 340]
length(co2[co2 > 340])
length(co2[co2 <= 340])
# did we get them all?
195 + 273
# indeed, this is all of the values
v <- co2[co2 > 340]
# could use the negative operator
w <- co2[ !(co2 <= 340) ]   # denotes NOT less than 340
v == w

# logical operators we can use are:
#   & AND
#   | OR
#   ! NOT
