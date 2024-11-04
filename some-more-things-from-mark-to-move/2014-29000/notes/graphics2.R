# list of all named colors in R and their hexadecimal values:
#   http://tolstoy.newcastle.edu.au/R/help/00a/0546.html

# for instance,
par(fg="#9932CC")
plot(pressure)

# you might accidentally send a single digit number to the fg parameter
par(fg=4)
plot(pressure)
# why? the most basic colors in the palette have simple number representations:
palette()

# another scheme is to hsv or hcl colors,
# these go beyond R graphics, very popular in computing and art in general

# for instance, hsv:
# hue is 0 for red, 1 for violet
# saturation 0 for dull 1 for bright
# value is 0 for dark, 1 for light

# hsv stands for hue-saturation-value
# hcl stands for hue-chroma-value

#example:
hcl(seq(0,360,length=7), 50, 60)  # fix brightness 50, fix luminance at 60
# makes sense to discard this repeated value at the end,
hcl(seq(0,360,length=7)[-7], 50, 60)

# more examples
?convertColor
# convert between different color spaces
?rgb2hsv
# convert between rgb and hsv

# transparency, by sending a 4th parameter with our colors:
par(fg=rgb(153/255, 50/255, 204/255, 0.3))  # this is transparency level 0.3
plot(pressure)
# play with the 4th parameter, 0.01, for instance, would be very transparent; 0.99 would not be transparent!

# color schemes
example(rainbow)
# several different schemes

# we can generate hexadecimal colors along one of these schemes,
# for instance,
# terrain.colors go from white through brown to green
# topo.colors go from white through brown then green to blue
# cm.colors go from light blue through white to light magenta
# for example
topo.colors(10)
terrain.colors(20)
