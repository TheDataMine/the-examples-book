# The list.files command can be used to analyze the file structure in UNIX, from within R.
# For example, we can recursively list all files inside the AirBnB directory structure.
# In other words, R looks deeper and deeper into the directories
# and finds all of the files there, no matter how deep they are.
myfiles <- list.files("/class/datamine/data/airbnb/", recursive=T)


# Suppose that we want to study the listings.csv files within this directory.
# We might initially search for file names that include the phrase listings.csv
myfiles[grepl("listings.csv",myfiles)]
# but unfortunately we also get a lot of zipped files too, named listings.csv.gz
# so we can limit our search, to remove those.
myfiles[grepl("listings.csv",myfiles) & !grepl("listings.csv.gz",myfiles)]

# Just FYI:  grepl() takes a vector of strings,
# and checks whether it contains the target string.

# Now we have a listing of all of the files in the AirBnB directory that are called "listings.csv".
# By the way, as a side note, notice that, for instance, in entry 35,
# Ireland has an entry that is not limited to one city.
# Also notice that some directory paths have non-alpha characters, but R can deal with this.
# For instance, some of them have a percent symbol in the file path.

# Now we build a listing of the exact locations of all listings.csv files:
mylistings <- paste0( "/class/datamine/data/airbnb/", 
  myfiles[grepl("listings.csv",myfiles) & !grepl("listings.csv.gz",myfiles)]
)

# That was relatively painless.
# These are the 101 files in the AirBnB directory of the form "listings.csv":
mylistings

# Now we prepare to build a comprehensive data frame that has all of the reviews for all of the AirBnB listings.
# We first store the data frames in a list:
myresults <- sapply(mylistings, read.csv)

# This is a list of 101 data frames
class(myresults)
length(myresults)

# Here are three good uses of the "sapply" function:

# First, we can check that every entry in "myresults" is actually a data frame:
sapply(myresults, class)
sum(sapply(myresults, class) == "data.frame")
sum(sapply(myresults, class) != "data.frame")

# Secondly, we can use sapply to easily see that the entries in the list do not all have the same number of columns (some have 16 columns, but one has only 15 columns):
sapply(myresults, dim)
sum(sapply(myresults, dim)[2, ] == 16)
sum(sapply(myresults, dim)[2, ] == 15)
# Argh!  One of them has only 15 columns.

# Now we are ready to embark on this project, to build one data frame from several data frames.

