#  How to scrape data from the web and then parse it.
#  Example 6

# Here is an example for how to extract the Indiana presidential votes from 2012.

library("XML")

# We first download the data from the internet.
mydoc <- htmlParse("http://www.politico.com/2012-election/results/president/indiana")

# We extract the names of the candidates for President.
names <- xpathSApply(mydoc, "//*/th[@scope='row' and @class='results-candidate']/child::text()", xmlValue)
# We also extract the votes from each county.
votes <- xpathSApply(mydoc, "//*/td[@class='results-popular']/child::text()", xmlValue)

# They both have the same length, namely, 279.
# There are 92 counties, with 3 entries per county.
# That accounts for 276 of the entries.
# Plus we get the summary data in the first entry.
length(names)
length(votes)

# It helps to examine the head of the names and votes vectors
head(names)
head(votes)

# Then (for consistency,
# since we see that not all of the names have uniform spacing,
# we remove the spaces from the names using the gsub command.
names <- gsub(" *", "", names)

# We also remove the spaces from the votes.
votes <- gsub(" *", "", votes)
# We also remove the commas from the votes too, so that
# we can convert the votes to numerical values.
votes <- gsub(",", "", votes)
votes <- as.numeric(votes)

# Finally, we remove the first 3 entries of the votes and the names,
# since they each contain the summary data.
names <- names[-(1:3)]
votes <- votes[-(1:3)]

# Now we can get the tally of the votes in Indiana, using tapply.
tapply(votes, names, sum)




