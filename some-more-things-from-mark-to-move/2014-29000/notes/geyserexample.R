library(MASS)
?geyser

head(geyser)

geyser$waiting
geyser$duration

# maybe we want to classify the duration of an eruption according to the waiting time in between eruptions
# problem: the eruptions are not a factor; they are a vector of integers,
# so we need to group them in some natural way:
range(geyser$waiting)
cut(geyser$waiting, breaks=seq(40,110,by=10))

tapply( geyser$duration,  cut(geyser$waiting, breaks=seq(40,110,by=10)),  mean)
# in the result, at the top of the table, we have the waiting times (in minutes) by groups
# the averages we took are averages of the durations of the eruptions, within each group

# we might conjecture (for instance) that as the waiting times go up, the duration of eruptions goes down:
plot( geyser$waiting, geyser$duration )
