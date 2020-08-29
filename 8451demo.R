# We read in the data from the 8451 data set
# (This is not the same data set from Project 2!
#  It is only intended to give you an idea about how to use basic functions in R!)
# The read.csv function is used to read in a data frame.
# The variable myDF will be a data frame that stores the data.
myDF <- read.csv("/class/datamine/data/8451/The_Complete_Journey_2_Master/5000_transactions.csv")

# Please give the data frame a minute or two, to load.  It is big!

# The data frame has 10625553 rows and 9 columns:
dim(myDF)

# This is the data that describes the first 6 purchases:
head(myDF)

# Similarly, these are the amounts spent on the first 6 purchases.
# We use the dollar sign to pull out a specific column of the data
# and focus (only) on that column.
head(myDF$SPEND)

# These first 6 values in the SPEND column
# add up to a total sum of 7.18 (you can check by hand if you like!)
sum(head(myDF$SPEND))

# The average of the first 6 values in the SPEND column is 1.196667
mean(head(myDF$SPEND))

# The first 100 values in the SPEND column are:
head(myDF$SPEND, n=100)
# Note that, in the line above, we have an "index" at the far left-hand side
# of the Console.  It shows the position of the first value on each line.
# The values will change, depending on how wide your screen is.

# Here is the 1st value in the SPEND column:
myDF$SPEND[1]
# Here is the 22nd value in the SPEND column:
myDF$SPEND[22]
# Here is the 25th value in the SPEND column:
myDF$SPEND[25]

# Here are the last 20 values in the SPEND column.
# (Notice that we changed head to tail,
#  since tail refers to the end rather than the start.)
tail(myDF$SPEND, n=20)

# We can load the help menu for a function in R by using
# a question mark before the function name.
# It takes some time to get familiar with the style of the R help menus,
# but once you get comfortable reading the help pages,
# they are very helpful indeed!
?head

# We already took an average of the first 6 entries in the SPEND column.
# Now we can take an average of the entire SPEND column.
mean(myDF$SPEND)

# Again, here are the first six entries in the SPEND column.
head(myDF$SPEND)

# Suppose that we want to see which entires are bigger than 2
# and which ones are smaller than 2.  Here are the first six results:
head(myDF$SPEND > 2)

# Now we can see what the actual values are.
# Here are the first 100 such values that are each bigger than 2.
head(myDF$SPEND[myDF$SPEND > 2], n=100)

# You might want to plot the first 50 values in the SPEND column:
plot(head(myDF$SPEND, n=50))
# If the result says "Error in plot.new() : figure margins too large"
# then you just need to make your plotting window a little bigger,
# so that R has room to make the plot, and then run the line again.

# There are 10625553 entries in the SPEND column:
length(myDF$SPEND)

# This makes sense, because the data frame has 10625553 rows and 9 columns.
dim(myDF)

# There are 6322739 entries larger than 2.
length(myDF$SPEND[myDF$SPEND > 2])

# There are 451155 entries larger than 10.
length(myDF$SPEND[myDF$SPEND > 10])

# There are 4197 entries less than -3.
length(myDF$SPEND[myDF$SPEND <= -3])

# We encourage you to play with the data sets,
# and to learn how to work with the data, by trying things yourself,
# and by asking questions.  We always welcome your questions,
# and we love for you to post questions on Piazza.
# This is a great way for the entire community to learn together!

