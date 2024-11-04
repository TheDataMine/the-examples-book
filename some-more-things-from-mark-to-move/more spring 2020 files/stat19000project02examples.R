# let's read in some data from online about wine
dat <- read.csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-28/winemag-data-130k-v2.csv')

# looks like description was converted to a factor, lets fix this
str(dat)

# much better
dat <- read.csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-28/winemag-data-130k-v2.csv', stringsAsFactors = F)
str(dat)

# get dimensions
ncol(dat)
nrow(dat)

# or all at once...
dim(dat)

# let's create a list of fruits
fruits <- c("pineapple", "orange", "cherry")

# let's write a function that accepts a list of strings
# and a sentence. if any of the strings appears in the
# sentence, return TRUE
has_strings <- function(sentence, fruit_strings) {
  return(grepl(paste(fruit_strings, collapse="|"), sentence))
}

# returns F as we expect
has_strings("This is a sentence that doesn't have any fruit names in it.", fruits)

# these should return T
has_strings("This is a cherry.", fruits)
has_strings("I have some cherrys, but don't know how to spell.", fruits)
has_strings("I have a pineapple, many cherries, and an orange.", fruits)

# lets get a subset of the wine data where any of the fruits we listed
# are present in the desciption of the wine
fruity_wines <- dat[sapply(dat$description, has_strings, fruits),]

# how about wines that are less appealing?
gross <- c("dust", "dusty", "mildew")
gross_wines <- dat[sapply(dat$description, has_strings, gross),]

# we can look at a string letter by letter this way
letters <- strsplit("I have some cherrys, but don't know how to spell.", "")

# which indices are 'o'
which(letters[[1]]=="o")

# what is the highest points a wine has earned?
max(dat$points)

# which wine(s) scored the max?
dat[which.max(dat$points),]

# the average price of those wines?
mean(dat[which.max(dat$points),]$price)

# yikes, lets plot the prices
hist(dat[which(dat$points==100),]$price)

# seems to be a couple of interestingly priced wines...
# you can get perfectly scored wines for 80 or 1500
range(dat[which(dat$points==100),]$price)

# let's see from what county the highest priced wines are from
dat[which(dat$price==1500),]

# let's take a look at those wines that have perfect score but are < $100
dat[which(dat$price < 100 & dat$points==100),]

# let's split our dataset up by the points they score
myresults <- split(dat, dat$points)

# now you can do things like the following
myresults$`100`$variety
myresults$`80`$price

# or instead
myresults <- split(dat, dat$country)

# then do things like
max(myresults$Portugal$price, na.rm=T)
max(myresults$Argentina$price, na.rm=T)

# other useful functions
class(myresults)
length(myresults)
length(myresults$Brazil)

# France sure has a lot of wines, although not the easiest to read
sapply(myresults, dim)

# That is better
sapply(myresults, dim, simplify=F)

# If you are interested in a certain country
sapply(myresults, dim, simplify=F)$France

# Some more examples
sapply(myresults, head)
sapply(myresults, head, simplify=F)

# You can even do things like
dat2 <- subset(dat, select=c(price, points))
sapply(dat2, max, na.rm=T)/sapply(dat2, min, na.rm=T)

