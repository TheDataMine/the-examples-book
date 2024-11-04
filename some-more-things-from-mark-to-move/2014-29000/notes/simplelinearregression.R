# simple linear regression model
# in R we use the lm function to find such a model

# for our example, we'll use the trees built-in data set from R

?trees
# the involves some girth, height, and volume data for some black cherry trees

head(trees)

# doesn't look like a natural linear relationship:
plot(trees$Height, trees$Volume)
plot(trees$Height, trees$Girth)

# might be a natural linear relationship
plot(trees$Girth, trees$Volume)

# Let's see if we can determine how the volume might depend on the Girth

# We are thinking about using Girth as an x-variable, i.e., as the independent variable
# and seeing how the y-variable (the dependent one) depends on it.
# i.e., ask R to model how the volume changes based on the girth

lm(trees$Volume ~ trees$Girth)
# we get a y-intercept and a slope for a potential kind of line that
# might model this linear relationship

# there are two ways to plot the line suggested by this linear model:
# one way is to give the linear model a name, e.g., mylm:
mylm <- lm(trees$Volume ~ trees$Girth)
abline(mylm)

# another way is to compute where the line should be manually
plot(trees$Girth, trees$Volume)
abline( -36.943, 5.066 )
# same effect as we saw above.

# Now let's get some of the information from the model
summary(lm(trees$Volume ~ trees$Girth))
# in particular, we have the y-intercept and the slope
# as a part of the summary

# we also have much more information
# for instance, we have the error in the model,
# but we could also (if we wanted to) calculate the error directly,
# just to verify for ourselves what is happening with the error calculation

# our estimate for the tree volume is  5.0659*trees$Girth - 36.9435
sqrt(mean((trees$Volume - (5.0659*trees$Girth - 36.9435))^2))
# this gives us the mean squared error, which is close to what R gets

# if we want to do it exactly R's way, we need to change slightly the 
# number of variables, which was originally 31, but R uses 2 less, i.e., 29
sqrt(sum((trees$Volume - (5.0659*trees$Girth - 36.9435))^2)/29)

# this exactly matches the residual standard error computed by R




