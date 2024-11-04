?iris

# check the data set:
head(iris)

# check that there are 50 of each type:
iris$Species
table(iris$Species)

# this last column of the data.frame is indeed a factor:
class(iris$Species)

# this has the same effect as the table command:
tapply(iris$Species, iris$Species, length)

# average and variance of the Petal.Width, according to Species:
tapply( iris$Petal.Width, iris$Species, mean)
tapply( iris$Petal.Width, iris$Species, var)

# what if we want the average Petal.Width, according to the Sepal.Width?
# one issue:  the Sepal.Width is not (naturally) a factor:
iris$Sepal.Width
# helps to break the Sepal.Width into ranges:
range(iris$Sepal.Width)
cut(iris$Sepal.Width, breaks=seq(1.9,4.4,by=0.5))

tapply( iris$Petal.Width, cut(iris$Sepal.Width, breaks=seq(1.9,4.4,by=0.5)), mean)
# the values that are labelling the result are the Sepal.Width's,
# and the averages themselves are of the Petal.Width's, broken up into groups,
# according to the Sepal.Width's (in ranges)

# could do this by hand, but again, it is more tedious and takes more keystrokes:
mean(iris$Petal.Width[iris$Sepal.Width > 2.4 & iris$Sepal.Width <= 2.9])

# to reproduce the same table as above, we need 5 such lines:
mean(iris$Petal.Width[iris$Sepal.Width > 1.9 & iris$Sepal.Width <= 2.4])
mean(iris$Petal.Width[iris$Sepal.Width > 2.4 & iris$Sepal.Width <= 2.9])
mean(iris$Petal.Width[iris$Sepal.Width > 2.9 & iris$Sepal.Width <= 3.4])
mean(iris$Petal.Width[iris$Sepal.Width > 3.4 & iris$Sepal.Width <= 3.9])
mean(iris$Petal.Width[iris$Sepal.Width > 3.9 & iris$Sepal.Width <= 4.4])

# it was much easier to use tapply, to take an average of the Petal.Width's,
# according to the Sepal.Width's (broken up into pieces)
