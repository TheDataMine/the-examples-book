?CO2
head(CO2)

# could take an average of all of the uptake values
mean(CO2$uptake)

# it would be more helpful, if we could (say) find mean values
# within the different types of experiments that are taking place

# tapply lets us do that
# R has a whole suite of apply functions, very powerful
# tapply is the first one we will learn
# We will do lots of examples.

# e.g., measure the uptake (say, by the average) according to the type
tapply( CO2$uptake, CO2$Type, mean)
# a longer way to do this is the following:
mean(CO2$uptake[CO2$Type == "Quebec"])
mean(CO2$uptake[CO2$Type == "Mississippi"])
# so the tapply is very efficient in terms of keystrokes, and in terms of our thinking

tapply( CO2$uptake, CO2$Treatment, mean)
# group the CO2$uptake data according to whether the experiment is nonchilled or chilled
# (this is where the CO2$Treatment classification comes in)
# and then take a mean of each group of data

mean(CO2$uptake[ CO2$Treatment=="nonchilled" ])
mean(CO2$uptake[ CO2$Treatment=="chilled" ])

# could also take an average within each concentration level
tapply( CO2$uptake, CO2$conc, mean)

# It is even possible to take a function when we group the data
# according to two or more classifications, for instance
tapply( CO2$uptake, list(CO2$Plant, CO2$Treatment), mean)
# this turned out to be redundant, but it is perhaps sufficient to just
# classify by Plant type in this case:
tapply( CO2$uptake, CO2$Plant, mean)

# here is a worthwhile time when we might want to break up the
# experiment data according to two classifications:
tapply( CO2$uptake, list(CO2$Plant, CO2$conc), mean) 
# we could do this manually but again it is a lot of keystrokes:

CO2$uptake[ CO2$Plant == "Qn1" & CO2$conc == 95]
# we would have to have many of these types of lines to reproduce the whole table

tapply( CO2$uptake, list(CO2$Treatment, CO2$conc), mean)
# we could have done this by hand:
CO2$uptake[ CO2$Treatment == "nonchilled" & CO2$conc == 95]
# now take a mean:
mean(CO2$uptake[ CO2$Treatment == "nonchilled" & CO2$conc == 95])
mean(CO2$uptake[ CO2$Treatment == "nonchilled" & CO2$conc == 175])
mean(CO2$uptake[ CO2$Treatment == "nonchilled" & CO2$conc == 250])
# etc., etc., takes many keystrokes to do this separately...

# in general, for tapply:
# we put:  a vector of data, a factor (or multiple factors in a list), and a function we want to apply to the data,
# once the data has been grouped according to the levels in the factor
