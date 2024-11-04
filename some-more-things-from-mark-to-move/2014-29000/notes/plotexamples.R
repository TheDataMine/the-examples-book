# examples of types of plots we can make in R

# barplots
example(barplot)

# stem and leaf plots
library(MASS)
head(geyser)
stem(geyser$waiting)

# we can change the default length of the lines and the number of lines
stem(geyser$waiting, scale=0.5, width=100)
range(geyser$waiting)

# histograms
hist(geyser$waiting)

# scatterplot
# the variable for the x axis, the variable for the y axis
plot(airquality$Ozone, airquality$Wind)

# the Wind will again be on the y axis, Ozone on the x axis
plot(airquality$Wind ~ airquality$Ozone)
# think: how does Wind depend on Ozone?

# scatterplot matrices
pairs(iris[1:4])
# more comprehensive example of this in the pairs examples:
# first look at this:
unclass(iris$Species)
pairs(iris[1:4], main="Anderson's Iris Data -- 3 species", pch=21,
      bg=c("red","green3","blue")[unclass(iris$Species)])

pairs( mtcars[c(1,4,6)])
pairs( mtcars[c("mpg", "hp", "wt")])   # same effect as the line above

# boxplot
example(boxplot)

# how to save the output of your plotting into a pdf file:
# for example:

pdf(file="bigexample.pdf")
pairs(iris[1:4])
hist(geyser$waiting)
plot(airquality$Ozone, airquality$Wind)
dev.off()   # this turns off the plotting to the pdf file, and closes the pdf file.


