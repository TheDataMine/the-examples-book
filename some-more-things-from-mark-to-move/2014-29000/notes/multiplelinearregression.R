# multiple linear regression

# again use the trees built-in data set from R

head(trees)

# let's see how we can predict the Volume from the Girth and the Height

# R's notation for building a model from two or more variables
# is to use a "plus" sign between the variables,
# it does not mean that we are adding together the variables.
# It's just R's notation to show that we are using two or more variables
# to build the model.
lm(trees$Volume ~ trees$Girth + trees$Height)

# this basically means that R is estimating the Volume to be (about)
#  -57.9877 + 4.7082*trees$Girth + 0.3393*trees$Height

# as before, we can get even more information about
# this multiple linear regression model
# by using the summary command
summary(lm(trees$Volume ~ trees$Girth + trees$Height))

# again, let's test to see if we can see why R gives us the 
# error that it does in the multiple linear regression model:
sqrt(mean((trees$Volume - (-57.9877 + 4.7082*trees$Girth + 0.3393*trees$Height))^2))
# this is close to the error given by R, but not exactly.
# R is dividing by 28 not 31 when it takes a mean
sqrt(sum((trees$Volume - (-57.9877 + 4.7082*trees$Girth + 0.3393*trees$Height))^2)/28)

# this is exactly the least squares error that R gives us in the summary






