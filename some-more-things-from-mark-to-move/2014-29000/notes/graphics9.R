# plotting regions, i.e., where do the plots appears in the plotting window?

# we use the omd parameter to adjust this
# the omd parameter takes 4 values (stored in a vector),
# namely x1, x2, y1, y2

# examples:
par(omd=c(.1,.7,.4,.9))
plot(pressure, pch=24, type="o", bg="blue")

par(omd=c(0,.4,.4,.9))
plot(pressure, pch=24, type="o", bg="blue")

par(omd=c(0,.4,.6,1))
plot(pressure, pch=24, type="o", bg="blue")

par(omd=c(0,.4,0,.5))
plot(pressure, pch=24, type="o", bg="blue")

# notice every time, the previous output is erased,
# when a new plot is drawn

# we can adjust this behavior with the new parameter
# by default, new is set to FALSE
# but if we change new to TRUE, then the old plots are retained
# when we make a new plot

par(new=TRUE)

par(omd=c(0,.4,.6,1))
plot(pressure, pch=24, type="o", bg="blue")

par(new=TRUE)

par(omd=c(.5,1,.6,1))
plot(pressure, pch=24, type="o", bg="blue")

par(new=TRUE)

par(omd=c(.5,1,0,.5))
plot(pressure, pch=24, type="o", bg="blue")

# some other parameters for plotting regions:

#Outer margins: NONE by default
#oma is a vector of four values, bottom, left, top, right, given in lines of text
#omi is a vector of four values, bottom, left, top, right, given in inches
#omd is a vector of four values, x1, x2, y1, y2, of values for the region of outer margins,
#    in normalized form (see examples above), i.e., using values from 0 to 1

#Figure regions
#fig is a vector of four values, x1, x2, y1, y2, of values for the figure region margins,
#   in normalized form i.e., using values from 0 to 1
#fin is a vector of two values, width and height, of values for the figure region margins
#   in inches. The figure region will be centered within the inner region, so
#   only the size (not the placement) is given

#Figure margins
#mar is a vector of four values, bottom, left, top, right, given in lines of text;
#    the default is mar = c(5,4,4,2) + 0.1
#mai is a vector of four values, bottom, left, top, right, given in inches
#mex is used to specify the size of the lines for the mar parameter

#Plot regions
#The plot region is usually calculated from the figure region minus the figure margins
#plt is a vector of four values, bottom, left, top, right, given in inches
#pin is a vector of two values, width and height, of values for the plot region in inches
#pty is "m" by default, so the plot region is all of the figure region
#    minus the figure margins, but we can set it to "s" so that the plot region
#    must be square but otherwise as large as possible.



