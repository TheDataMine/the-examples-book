# Once we install a library, we do not need to install it again,
# but we do need to still load it (like this) to use it:
library(ggmap)

# We can find help in several ways, including:
# 1.  Searching on Google, adding the phrase:
#        r-project
#     to the search is usually helpful for having Google give R tips.
# 2.  Using the built-in R help when we know the name of the command:
?geom_point
?runif
# 3.  Using the help.search when we do not know the name of the command:
help.search("geometric")

# The help pages can explain the parameters for a command,
# for example, in R, this generates 10 independent values
# with geometric distribution, and with parameter 1/3,
# and the help pages mention that these are geometric number of losses,
# i.e., they start from 0 not 1
rgeom(10, 1/3)

# Here is the sequence of integers from 1 to 10
1:10

# Here is the value 5, repeated 10 times
rep(5,10)
# We can also build sequences of various types, for instance:
v <- seq(from=2, to=50, by=2)
v

# This is the 3rd element of v
v[3]

# This is a variety of elements concatenated (or combined) together
c(19, 10:12, 15, 37)

# We can use those values as indices into v
v[c(19, 10:12, 15, 37)]

# If we store values into a vector, we do not see the values themselves
myvec <- runif(10)
# we need to explicitly ask to see such values
myvec
# here is the third such value
myvec[3]
# here are the third and fifth such values
myvec[c(3,5)]

# R is good at indexing

# There are 4 ways to index in R
#1.  use logical indices, i.e., TRUE and FALSE (also called T and F)

# these show which values of myvec are bigger than 0.5
myvec > 0.5
# this uses those T and F values as indices,
# to actually retrieve the values of myvec that are bigger than 0.5

# Here are the first five values in myvec:
myvec[c(T,T,T,T,T,F,F,F,F,F)]

# This is another way to accomplish that:
myvec[c(rep(T,times=5),rep(F,times=5))]

# For another example, we build a vector w:
w <- c(22, 12, 42, 10, 5, 20, 13)
# These are T and F values that indicate whether
# the values of w are larger than 15 or not:
w > 15
# these are those actually values of w that are bigger than 15:
w[w>15]
# or less than 15:
w[w<15]
# or equal to 15:
w[w==15]

#2.  use numerical indices, i.e., the actual indices that we want:

# here are 20 random values, uniformly distributed between 0 to 1:
w <- runif(20)
w

# these are the first five values
w[1:5]
# and this is the last value
w[20]
# but if we did not know (or remember) that it had length 20,
# then we could get the last value this way:
w[length(w)]
# or the last three values:
w[(length(w)-2) : length(w)]
# here are the 13th, 15th, and 17th values:
w[c(13,15,17)]

#3. use negative indices
# Negative indices just let R know we do not want those elements:
w
w[-(1:5)]
w[-c(18,19,20)]

#4. name your vector elements

# for instance, here are my kids' ages:
wardvec <- c(14,12,9,6,4,0)
# and we can give names to these values:
names(wardvec) <- c("Bruce","Audrey","Mary","Luke","Dean","Joy")

# then we can refer to the values by their names:
wardvec["Bruce"] + wardvec["Audrey"]

# here is another example with the airline data:
myDF <- read.csv("http://stat-computing.org/dataexpo/2009/airports.csv")
head(myDF)

lat <- myDF$lat
lon <- myDF$long

# here are the first several latitudes and longitudes:
head(lat)
head(lon)

# it is good to check the classes of these vectors;
# in this case, these are numeric values:
class(myDF$lat)
class(myDF$lon)

# things I check a lot in R:
# length or dim of an object
# class of the object
# head and/or tail of the object
# etc...

# It is natural to name the latitude and longitude according to the
# name of the airport:
names(lat) <- as.character(myDF$airport)
names(lon) <- as.character(myDF$airport)

# The Thigpen airport has an extra space in its names:
lat["Thigpen "]
lon["Thigpen "]

# Here is the Capitol airport:
lat["Capitol"]
lon["Capitol"]

# Here is the Chicago Midway airport:
lat["Chicago Midway"]
lon["Chicago Midway"]

# and Indianapolis International airport:
lat["Indianapolis International"]
lon["Indianapolis International"]

# and O'Hare:
lat["Chicago O'Hare International"]
lon["Chicago O'Hare International"]

# In R, it is helpful to know about the and/or/not logical operators:
# and    &
# or     |
# not    !

# For example, here are 10 random values:
v <- runif(10)
v
# these are the ones bigger than 0.9:
v[ v > .9 ]
# less than 0.2:
v[ v < .2 ]
# and either bigger than 0.9 or less than 0.2:
v[ (v > .9) | (v < .2) ]

# these are the ones that are bigger than 0.1 and less than 0.4:
v[ (v > .1) & (v < .4) ]

# There are 12 airports for which the state is not listed:
is.na(myDF$state)
# We can see this by summing these values;
# when we do this, FALSE is 0 and TRUE is 1:
sum(is.na(myDF$state))

# Here are the 12 rows of the data.frame that are missing the states:
myDF[ is.na(myDF$state)  ,   ]


