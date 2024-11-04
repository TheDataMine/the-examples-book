#data symbols that can be used on the plot

# pch to set the data symbol
# the example shows the basic 26 types, and more
example(pch)

plot(pressure, pch=3)
plot(pressure, pch=13)
plot(pressure, pch=17)
plot(pressure, pch=25)

# can also use characters instead of symbols:
plot(pressure, pch="R")

# we can have lines that either go through the points being plotted
# or that skip over the points being plotted
plot(pressure, pch="R", type="b")
plot(pressure, pch="R", type="o")

# some of the point symbols can use colors, and others cannot:
plot(pressure, pch=13, type="o", bg="blue")  # the color does not appear
plot(pressure, pch=23, type="o", bg="blue")  # the color does appear
# color only works with the higher-numbered symbols

plot(pressure, pch="A", type="o")


