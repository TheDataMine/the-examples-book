# Paul Murrell's book on RGraphics is highly recommended
# some of my examples inherit strongly from his presentations
# https://www.stat.auckland.ac.nz/~paul/RGraphics/rgraphics.html

# one example for colors into R plot:
plot(pressure, col.axis="darkgreen", col.lab="blue", col.main="red", col.sub="purple",
     main="Vapor Pressure of Mercury as a Function of Temperature", sub="with some fancy colors")

# can also specify the foreground and background colors,
# but we should use par() function to do so
par( fg="purple", bg="orange", col.lab="red" )
plot(pressure)

# there are many ways to specify the colors we want to use in R:

# one way is just use the color name directly:
par(fg="red")
plot(pressure)

# convert a named color to rgb values, and then use the rgb values:
col2rgb("darkorchid")
par(fg=rgb(153,50,204,maxColorValue=255))
plot(pressure)

# the default is 1 not 255, so we could scale by colors/255, to avoid using the maxColorValue parameter:
par(fg=rgb(153/255,50/255,204/255))
plot(pressure)

# what are the other named colors?  what are their rgb values?
mymatrix <- col2rgb(colors())  # get the rgb values of the named colors
colnames(mymatrix) <- colors() # name the columns of the matrix to have these named colors
t(mymatrix)    # take a transpose, i.e., convert columns to rows and vice versa

