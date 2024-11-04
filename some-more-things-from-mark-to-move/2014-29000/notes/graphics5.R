#end of lines, and how lines are joined together

plot(pressure)
par(lwd=50)  # makes very thick lines

# now we will plot line segments from
# (50,200) to (150,400) to (50,600)
par(lend="butt"); lines(c(50,150,50), c(200,400,600))
par(lend="round"); lines(c(50,150,50), c(200,400,600))
par(lend="square"); lines(c(50,150,50), c(200,400,600))

# good idea to clear the plots here

# how are lines joined together?
plot(pressure)
par(lwd=50)

# 3 options for joining lines: bevel, round, mitre
par(ljoin="bevel"); lines(c(50,150,50), c(200,400,600))
par(ljoin="round"); lines(c(50,150,50), c(200,400,600))
par(ljoin="mitre"); lines(c(50,150,50), c(200,400,600))

# the last possibility (mitre), for lines meet at an angle of
# 10 degrees or less, the join is converted to bevel

# one more note:
# we must use par for lend, ljoin, lmitre



