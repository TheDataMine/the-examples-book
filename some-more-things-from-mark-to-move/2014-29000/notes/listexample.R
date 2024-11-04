# examples with lists
# think: lists are like data.frames in that each "column" of a list
#   can have a different kind of data than the other "columns"
# lists are not exactly like data.frames because lists can have each "column"
#   of a possibly different length,
# in other words, lists do not have to have a rectangular shape at all.

# lists are simply collections of vectors (or other objects) of data, of possibly different types
?list

# example of building a list:
mylist <- list( mynums=1:10, somenames=c("bob", "alice", "eugene"), scores=c(80,99,95,72), randnums=runif(15), morenums=1:6)

# we can check the length
length(mylist)

# we can extract, "column"-by-"column" way as before:
mylist$mynums
mylist$somenames
mylist$scores
mylist$randnums
mylist$morenums
# we can also extract by using numbers instead of names for the various components:
mylist[[1]]
mylist[[2]]
mylist[[3]]
mylist[[4]]
mylist[[5]]

# we can check and see that mylist is of class "list"
class(mylist)

# we can check the classes of the individual components:
class(mylist$mynums)
class(mylist$somenames)
class(mylist$scores)
class(mylist$randnums)
class(mylist$morenums)

# in general, we can do the same kinds of things we could do with data.frames,
# e.g., store different kinds of data in each component,
# but the benefit of using lists instead of data.frames is that lists are not confined
# to having each component of the same length (and indeed each component does not even have to be a vector)


