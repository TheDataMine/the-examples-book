# lines in R
# 5 kinds of state settings: lty, lwd, lend, ljoin, lmitre

# if you want to read more about these:
?par

# which line type do we want, when plotting?
# 0=black, 1=solid (default), 2=dashed, 3=dotted, 4=dotdash, 5=longdash, 6=twodash

# examples:
plot(pressure, type="l", lty=4)
plot(pressure, type="l", lty="twodash")

# we can customize,
# give a string of up to 4 pairs (8 numbers total),
# line, gap, line, gap, line, gap, line, gap
plot(pressure, type="l", lty="2868")
# here we have a line of length 2, a gap of 8, line of length 2, gap of 8

# in the pre-set versions above
# dashed means 44
# dotted means 13
# dotdash means 1343
# longdash means 73
# twodash means 2262
# thanks to Paul Murrell's RGraphics for pointing these out

# for instance, these two have the same effect:
plot(pressure, type="l", lty="2262")
plot(pressure, type="l", lty="twodash")
# line of length 2, gap of length 2, line of length 6, gap of length 2

