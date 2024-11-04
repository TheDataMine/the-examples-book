# We read in the Data Expo airline data from 2005.
# It gets stored in a data frame that we call myDF.
myDF <- read.csv("~/2005.csv")

# We can see the first six rows of the data frame
# by looking at the head.  Notice that in the terminal,
# the head gives the first ten rows (as a default)
# but R gives us six rows as a default.  Also notice
# that the output is split because our screens
# are not wide enough to see all 29 columns at once.
head(myDF)

# We can look at a particular column of the data,
# for instance, the origin airports (i.e., where the
# flights departed), but note thar there are
# more than 7 million rows in the data frame,
# and we do not want to physically see all 7 million,
# so we just print the head of the column that
# contains the origin airports.
head(myDF$Origin)

# As a side note: in the output of the head command,
# we see the first six origin airports,
# and we see a list of all 279 possible values,
# among the 7 million airports in this column.
# This is called a "factor" (which means a vector that has
# only finitely many possible values).
# The possible values themselves are called "levels".

# If we want to know how many times that each airport
# occurred as the origin of a flight, then we can
# tabulate the results using the table command.
table(myDF$Origin)

# We can sort the results in the line above, as follows:
sort(table(myDF$Origin))

# We can find the average departure delays:
mean(myDF$DepDelay)

# but unfortunately some of the values are missing.
# In R, we have a value NA when a value is missing.
# To ignore such values, we use na.rm = T
mean(myDF$DepDelay, na.rm=T)

# The average departure delay is 7.892655 minutes.

# As one last example, suppose that we want to
# find the average departure delays for only the
# flights that depart from IND.

# First, we make a vector that has 7 million true
# and false values, according to whether or not the
# flight departed from IND.
# We do not want to see all 7 million such values,
# but here are the first six of them:
head(myDF$Origin == "IND")

# Now we use this vector as an index into the 
# departure delays, so that we only select the 
# values of departure delays for the flights that 
# depart from IND.
# Here are the departure delays of the
# first six flights that depart from IND.
head(myDF$DepDelay[myDF$Origin == "IND"])

# As before, we can take a mean:
mean(myDF$DepDelay[myDF$Origin == "IND"])

# but some of the values are missing,
# so we can remove the missing values:
mean(myDF$DepDelay[myDF$Origin == "IND"], na.rm=T)

# The average departure delay is 5.277935 minutes.

# Finally, we point out that it is possible
# to load help menus for R, by putting a question mark
# before the command.  For instance:

?sort
?mean
?head

