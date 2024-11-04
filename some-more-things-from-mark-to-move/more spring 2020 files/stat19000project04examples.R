# let's read in some online data about wine as a data.frame,and call it "wine_dat".
# as in previous examples, we make sure that strings are not converted to factors.
wine_dat <- read.csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-28/winemag-data-130k-v2.csv',  stringsAsFactors = F)

# let's see what our data looks like. It is always good to take a peek at the data,
# and see how its structured, and what we have going on
head(wine_dat)
str(wine_dat)
names(wine_dat)

# we can create a function that takes one argument (arg), and calculates it's squared value
my_awesome_function <- function(arg){
        return(arg^2)
}

# let's test it out on the price of wines
my_awesome_function(wine_dat$price[1])
my_awesome_function(wine_dat$price[1:3])

# if we don't provide a return(), the function will return the last evaluated expression
my_awesome_function <- function(arg){
        arg^2
}

# let's test it out
my_awesome_function(wine_dat$price[1])
my_awesome_function(wine_dat$price[1:3])

# what happens if we assign that last value to a variable called 'x'?
my_awesome_function <- function(arg){
        x <- arg^2
}

# let's test it out
my_awesome_function(wine_dat$price[1])
my_awesome_function(wine_dat$price[1:3])

# notice what happens when we assign the function result to another variable
squared_price <- my_awesome_function(wine_dat$price[1:3])
squared_price

# here is a function that accepts two arguments and returns a result
my_awesome_function_two <- function(arg, pow) {
        arg ^ pow
}

# let's try this one
my_awesome_function_two(2, 3)

# make sure and pay attention to order, it matters
my_awesome_function_two(3, 2)

# we can even use these user-defined functions with the apply suite
simple_data <- array(c(1,2,3,4,5))
apply(simple_data, 1, my_awesome_function)

# be careful, apply needs an array or a matrix so this won't work
bad_data <- c(1,2,3,4,5)
apply(bad_data, 1, my_awesome_function)

# if we made a matrix, you must specify to calculate row-wise or column wise
simple_matrix <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=3)
apply(simple_matrix, 1, sum)
apply(simple_matrix, 2, sum)

# if you have a function that accepts multiple arguments,
# you can tack those arguments in the "..." part of the function
apply(simple_data, 1, my_awesome_function_two, 3) # this cubes every argument

# functions can take as many arguments as we want, and arguments can have default values as well
# for example, in the function below we can provide two summaries for my data vector.
# the first is the mean and std deviation (recommended for symmetric data)
# the second is the median and the IQR (https://en.wikipedia.org/wiki/Interquartile_range)
my_data_summary <- function(my_vector, symmetric = T){
        if(symmetric){
                result <- c(mean(my_vector), sd(my_vector))
        }else if(!symmetric){
                result <- c(median(my_vector), unname(diff(quantile(my_vector, probs=c(.25,.75)))))
        }
        return(result)
}

# what are the summaries for wine prices?
my_data_summary(wine_dat$price)

# oops, we forgot to remove NAs
# we can use the argument "..." to pass arguments to other functions such as mean, sd, and quantile
my_data_summary <- function(my_vector, symmetric = T, ...){
        if(symmetric){
                result <- c(mean(my_vector,...), sd(my_vector,...))
        }else if(!symmetric){
                result <- c(median(my_vector,...), unname(diff(quantile(my_vector, probs=c(.25,.75), ...))))
        }
        return(result)
}

# lets evaluate it and give the option na.rm = T to remove NAs
my_data_summary(wine_dat$price, na.rm = T)
my_data_summary(wine_dat$price, F, na.rm = T)

# functions in R can accept and return any object, including other functions,
# lists, vectors, or data.frames containing multiple values as shown above
# let's try summary function function
my_new_data_summary <- function(...){
        args <- list(...)
        lapply(args, mean, na.rm = TRUE)
}
my_new_data_summary(wine_dat$price, wine_dat$points, wine_dat$points+wine_dat$price)

# we can peek into our created function (and any other R function) by using the following commands:
my_data_summary

# function's code:
body(my_data_summary)

# function's arguments:
formals(my_data_summary)

# function's enviroment
environment(my_data_summary)

# the enviroment of the function is important due to scoping rules
# let's see an example
wine_price <- 85
add_one <- function(wine_price){wine_price + 1}

# let's try
add_one(1)

# what if our function was
my_add_one <- function(){wine_price + 1}
my_add_one()

# was one added to our wine_price?
wine_price

# now let's see what happens when we do this
my_function <- function(wine_price){
        wine_price <- 10
        my_add_one()
}

# what would you expect the answer for my_function(10) and my_function(1) be?
# let's try it
my_function(10)
my_function(1)

# note that my_add_one was created in the global enviroment
environment(my_add_one)

# and in the global enviroment wine_price has value 85
# understanding R scoping rules is important to make sure
# your functions are performing as expected.

# read more about Scoping Rules:
# 'https://r4ds.had.co.nz/functions.html#environment'
# 'http://adv-r.had.co.nz/Functions.html#lexical-scoping'

# for more information and examples look:
# 'https://r4ds.had.co.nz/functions.html'