# We revisit the examples
# from September 6
# but using R instead of awk

# We again read in the 2005.csv airline data:
myDF <- read.csv("/depot/statclass/data/dataexpo2009/2005.csv")

# We can check the dimensions of
# the resulting data frame
# and we see that there are 
# more than 7 million rows
# and exactly 29 columns
dim(myDF)
  
# The first 6 rows are seen with the head
head(myDF)

# To see only the 19th column, 
# we can ask for it by the column number:
head(myDF[[19]])

# but it is somehow better to
# ask for the column by its name,
# which in this case is:
head(myDF$Distance)

# We can build a column of TRUE and FALSE
# values, according to whether the distance
# is bigger than 500 or not:
head(myDF$Distance > 500)

# and then we can restrict the rows 
# so that we only have these rows.
# We do not put a restriction on the columns.
# Please note the comma.
# We have restrictions on the rows go BEFORE the comma
# and restrictions on the columns go AFTER the comma
head(myDF[myDF$Distance > 500, ])

# We have 3.9 million such flights, by the way:
dim(myDF[myDF$Distance > 500, ])

# Same thing, but with flights that have 
# distances exceeding 1000; there are
# only 1.5 million such flights:
dim(myDF[myDF$Distance > 1000, ])

# We can sum all of the mileages for
# some of the flights.
# In awk, we added up the mileages
# for the "head" which was the header
# and the next 9 lines.
# In R, we just specify that we want
# to consider the first 9 flights in the head,
# and then we sum their mileages.
sum(head(myDF$Distance, n=9))

# It agrees with our work in awk,
# i.e., these flights traveled 7803 miles.

# We can try to sum all of the mileages
# but we get an error:
sum(myDF$Distance)

# we follow the advice in R,
# and we convert to numeric values
# (we will discuss this more later)
sum(as.numeric(myDF$Distance))

# Just like we saw in awk,
# we again verify that the airplanes
# flew 5167936343 miles altogether in 2005.

# We can display the departure delays
# and the mileage at once.
# To do this, we need to ask for
# both the 16th and 19th columns.
# We join 16 and 19 together with the "c" function,
# which combines the values ("c" stands for "combine")
# Here is the head of the resulting data frame,
# which has only these two columns.
head(myDF[ , c(16,19)])

# If we want to add the departure delays, 
# we get NA because some of the values are not available:
sum(myDF$DepDelay)

# but if we remove the NA's, then we can
# add the departure delays:
sum(myDF$DepDelay, na.rm=T)

# We can find the flights that departed from BOS.
# There are 128006 such flights.
dim(myDF[myDF$Origin=="BOS", ])

# There are 465714 flights that
# departed from BOS or ORD.
dim(myDF[ (myDF$Origin=="BOS")|(myDF$Origin=="ORD"), ])

# There are 7426 flights that
# departed from BOS and landed at ORD.
dim(myDF[ (myDF$Origin=="BOS")&(myDF$Dest=="ORD"), ])

# For the last example,
# we can add the mileage (distance in miles)
# for all flights that depart from each airport:
tapply(myDF$Distance, myDF$Origin, sum, na.rm=T)

# We can sort that output too:
sort(tapply(myDF$Distance, myDF$Origin, sum, na.rm=T))

# This function is one of the powerful functions
# that R provides, which we will explain in the near future.
# It tabulates data (in this case, myDF$Distance)
# according to another source of data
# (in this case, according to myDF$Origin)

# We will discuss this more, but for now, we can
# easily check that this agrees with the output from awk,
# from two weeks ago.


