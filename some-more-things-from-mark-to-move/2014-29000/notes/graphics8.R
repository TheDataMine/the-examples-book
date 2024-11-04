# axes in R plots

# first of all, R has an algorithm for setting how many
# ticks on an axes; we can request approximately that many ticks,
# but we only (usually) get approximately that many, not exactly that many
par(lab=c(40,20,7))  # 40 on x-axis, 20 on y-axis, 7 spacing
plot(pressure)

# xamp, yamp are not usually needed

# mgp sets the following:
# 1 position of the overall axis label
# 2 tick mark labels
# 3 lines for the ticks

# the default is:
par(mgp=c(3,1,0))
plot(pressure)

par(mgp=c(1.5,1,0))
plot(pressure)

par(mgp=c(1.5,.5,0))
plot(pressure)

par(mgp=c(1.5,.5,.2))
plot(pressure)

par(mgp=c(1.5,.5,-.2))
plot(pressure)

# we can also adjust the tick marks, two ways:
# tcl which is the length of the tick marks
# tck which is also the length, but relative to width and height

par(tcl=-.5)
plot(pressure)

par(tcl=.5)
plot(pressure)

par(tcl=3)
plot(pressure)

# remember that tck is relative to the overall width and height
# so fractions are sufficient
par(tck=1)
plot(pressure)

par(tck=.3)
plot(pressure)

par(tck=-.02)
plot(pressure)

# xaxs, yaxs, probably not needed 
par(xaxs="i")
plot(pressure)

par(yaxs="i")
plot(pressure)

par(xaxs="r", yaxs="r")  # this is the default
plot(pressure)

# we can make the axes labels disappear
par(xaxt="n")
plot(pressure)

par(yaxt="n")
plot(pressure)

# xlog, ylog change the scale of the axis
# bty controls the number of axes that are shown

plot(pressure)

par(bty="o")
plot(pressure)

par(bty="l")
plot(pressure)

par(bty="7")
plot(pressure)

par(bty="c")
plot(pressure)

par(bty="]")
plot(pressure)

# remember of course xlim, ylim too, which we have seen before
# these are for limits on the x-axis and y-axis
