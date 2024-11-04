# let's read in some online data about wine as a data.frame and call it "dat"
# as in previous examples, let's make sure that strings are not converted to factors.
dat <- read.csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-28/winemag-data-130k-v2.csv',  stringsAsFactors = F)

# let's see what our data looks like. It is always good to take a peek at the data,
# and see how it is structured, and what information we have.
head(dat)
str(dat)
names(dat)

# we can take a look at the price distribution
summary(dat$price)

# for wines costing over 25, how many are from the US?
sum(dat$country[dat$price>25] == "US")

# hmm, that doesn't seem right. we need to make sure we remove the NAs when taking the mean.
# we can do that by using the argument na.rm
sum(dat$country[dat$price>25] == "US", na.rm = TRUE)

# for wines with NAs in the prices, how many are Iberian (from Spain and Portugal)?
sum(dat$country[is.na(dat$price)] %in% c('Spain', 'Portugal'), na.rm=T)

# let's get a mean price for each country using tapply
tapply(dat$price, dat$country, mean)

# yikes, we have a bunch of NAs. we probably need to use `na.rm` argument in the mean function
avg_price <- tapply(dat$price, dat$country, mean, na.rm = TRUE)
avg_price
# much better..

# which country has the highest average price for wine?
which.max(avg_price)

# minimum average price
min(avg_price)

# oops, we need to remember to remove the NAs.
min(avg_price, na.rm=T)

# we can calculate the overall pearson correlation between points and price
# for all complete observations
cor(dat$points, dat$price, use='complete.obs')

# let's create the variabe price category (0-low < 42, 1-high >=42)
dat$price_cat <- ifelse(dat$price < 42, 0, 1)

# let's write a function that takes a price and calculates the average point
# for the following
points_per_price <- function(price_category){
        mean(dat[dat$price_cat==price_category,'points'], na.rm=T)
}

# to see the average point per price category we could do this
sapply(0:1, points_per_price)

# now let's write a function that takes in a price category, and country
# calculates the average points for our dataset
gets_info <- function(country_name, price_category){
        mean(dat[dat$country==country_name & dat$price_cat==price_category,'points'], na.rm=T)
}

# now suppose we want the average points for the following countries and both price categories
# c('US', 'Germany', 'Argentina', 'Italy', 'Swizerland')
# note that we could obtain for category 0 (low) by doing
sapply(c('US', 'Germany', 'Argentina', 'Italy'), gets_info, 0)

# now we can iterate the sapply function above through both categories (0,1)
# by making the argument 0 into 'x'
sapply(0:1, function(x) sapply(c('US', 'Germany', 'Argentina', 'Italy'), gets_info, x))

# another useful function is called is.na(). roughly this function takes an input and returns a logical
# vector telling us if a value is missing.
is.na(c("This", "is", NA))
!is.na(c("This", "is", 4, NA))

# for merge examples look here
# 'https://www.statmethods.net/management/merging.html'