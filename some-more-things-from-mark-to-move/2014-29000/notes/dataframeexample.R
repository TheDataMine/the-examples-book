# examples with data.frames
# building a data.frame from scratch:

DF <- data.frame( mynums=1:10, mystrings=c("a","b","c","d","e","frank","egg","dog","hippo","zebra"),
                  randvalues=runif(10), score=c(92,80,88,85,40,99,98,87,87,86))

# the whole data.frame is displayed here:
DF

# we can extract columns, as we would have in other examples, e.g., with built-in data, or imported data
DF$mynums
DF$mystrings
DF$randvalues
DF$score

class(DF$mynums)
class(DF$mystrings)
class(DF$randvalues)
class(DF$score)

# just as we matrices, for instance, we can extract some of the columns we are interested in:
# here are two equivalent ways of extracting the 1st and 4th columns:
DF[c("mynums","score")]
DF[ c(1,4) ]



