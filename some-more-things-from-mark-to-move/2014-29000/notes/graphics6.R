# incorporate text into a plot at various points

# we can do this very precisely:

plot(pressure)
text(x=250, y=650, labels="this is x0y1", adj=c(0,1))
text(x=250, y=650, labels="this is x1y1", adj=c(1,1))
text(x=250, y=650, labels="this is x0y0", adj=c(0,0))
text(x=250, y=650, labels="this is x1y0", adj=c(1,0))

# adj is used to justify text directly in the middle of a plot

# mtext for margin text adjustments
mtext("this is on the left", side=1, adj=0)
mtext("this is on the right", side=1, adj=1)
mtext("this is sort of in the middle", side=1, adj=0.4)

plot(pressure)
mtext("this is on the bottom", side=2, adj=0)
mtext("this is on the top", side=2, adj=1)
mtext("this is sort of halfway up", side=2, adj=0.5)

title("my left title", adj=0)
title("my right title", adj=1)
title("my middle to right", adj=0.75)

# string rotations, with srt
text(x=100, y=200, labels="This text is printed on an angle", srt=30)

# las affects alignment of the labels
# ps for text size
# cex for text size multiplier

par(ps=18); text(x=100, y=300, labels="size 18 font example")
text(x=200, y=600, labels="1.5 times larger than the default font", cex=1.5)

# multiple lines of text
plot(pressure)
par(lheight=2)
text(x=250, y=400, labels="this is\nover two lines")
# the \n is the line ending command
# i.e., after \n, start a new line of text

# different kinds of fonts:
# 1 plain, 2 bold, 3 italic, 4 bold italic, 
text(x=250, y=750, labels="this is some italic text", font=3)
text(x=250, y=650, labels="this is bold italic now", font=4)

# different font families, e.g., Hershey
# also serif, sans, mono, symbol,
text(x=100, y=750, labels="this is Hershey font", family="HersheyGothicEnglish")

# note: such a font family needs to be specified with par or text
