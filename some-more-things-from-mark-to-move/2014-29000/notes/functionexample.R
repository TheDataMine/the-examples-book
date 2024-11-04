# we want to define a function that reverses the order
# of the elements and adds (say) 5 to each element

pizza <- function(v) {
  rev(v) + 5
}

pizza( c(3, 8, 10, 2, 0.5))
pizza( 1:20 )
pizza( 1:100 )

# another example:
# say we fix a vector 1:length(v) and add it to the vector v

anotherexample <- function(v) {
  w <- 1:length(v)
  v + w   # the last of the function is returned as the value
}

anotherexample( c(1, 7, 19, 10) )

# you can make function as you like,
# just remember the last line executed is the
# value of the function that gets returned
