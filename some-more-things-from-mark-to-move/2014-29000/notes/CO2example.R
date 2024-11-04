# remember that R is case-sensitive, i.e., these are two different data sets:
?co2
?CO2

# we focus right now on the latter one, CO2

CO2

# when the data set has many rows, it is helpful to use the head or tail functions:
head(CO2)
tail(CO2)
# either way, I can easily see the column headers, which is helpful

CO2$Type
# this is a particular kind of vector called a factor,
# which has just a few values that the entries can take
# the possible entries that can appear in a factor are called the levels; in this case, the possible
# levels are Quebec or Mississippi

CO2$Treatment
# this treatment is also a factor.  There are two possible levels, chilled or nonchilled

class(CO2$Type)
class(CO2$Treatment)

# the entire carbon dioxide data set, CO2, is a data frame, written data.frame
class(CO2)
# many of the data sets we will look at in the upcoming examples are data frames too
class(iris)
class(mtcars)
library(MASS)
class(geyser)

# a data frame consists of several columns,
# each column can have a different type of data stored in it.
# One important thing to note is that each column has to have the same length,
# so the overall shape of the data frame is a rectangle.
dim(CO2)
dim(iris)
dim(mtcars)
dim(geyser)
# So each data frame has some rows (usually many rows) and some columns (usually just a few columns),
# and each column is a different attributed or piece of information about the object described on that row.
# Since there are usually many rows in a data frame, that is why it is helpful to use the head and tail functions
# to just display a few of the rows, and get the names of the column headers.

# By using the column headers, we can extract a certain column of interest, and display it.
# If we display just one column, and the column is a factor, we will also see the levels.

# It is good to keep straight what the terms data.frame, factor, and levels are referring to.

