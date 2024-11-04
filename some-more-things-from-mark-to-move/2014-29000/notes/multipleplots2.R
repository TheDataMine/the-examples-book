# another way to put multiple plots into the same window
# we can use layout and layout.show

# for example:
layout(array(1:6, dim=c(2,3)))
layout.show(6)

curve(x^3)
curve(tan(x))
curve(5-x^2)
curve(cos(x))
curve(sin(x))
curve(10+x^3)

# you can change the size of the regions themselves
# one way is to specify the heights, for instance, and
# R will scale everything down to be percentages,
# for instance,

layout( matrix(c(1,2)), heights=c(4,1))
layout.show(2)
curve(x^2)
curve(sin(x))  # margins too large to display

layout( matrix(c(1,2)), heights=c(2,3))
layout.show(2)
curve(x^2)
curve(sin(x))

# one other scheme for putting multiple plots onto the same window
# split.screen
# I will not go into details on this method here,
# but it is good to know that it is available





