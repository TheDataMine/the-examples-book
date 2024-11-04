?mtcars
mtcars

# how many cars are there of each kind of cylinder?
table(mtcars$cyl)

# all of these give the same result, because we are just counting by the size of the groups,
# nothing pertaining to the data in the first component at all; any vector of length 32 will work in the first component:
tapply( mtcars$cyl, mtcars$cyl, length)
tapply( mtcars$mpg, mtcars$cyl, length)
tapply( 1:32, mtcars$cyl, length)
tapply( rep("a", times=32), mtcars$cyl, length)

# find the average miles per gallon, according to the number of cylinders:
# the 4, 6, 8 represent cylinders in the resulting table
tapply( mtcars$mpg, mtcars$cyl, mean)

tapply( mtcars$mpg, mtcars$am, mean)
# the 0 signifies automatic transmission; the 1 signifies manual transmission
