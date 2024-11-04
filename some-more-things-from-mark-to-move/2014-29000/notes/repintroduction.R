# replicate (repeat) elements in a vector:
?rep

x <- c(55, 8, 7, 1, 3)
# let's repeat the first element of x (say) 4 times
# and the second element of x (say) 2 times
# and the third element of x (say) 3 times
# and the fourth element of x just once
# and the fifth element of x just once
rep(x, times=c(4,2,3,1,1))

# we could (instead) have 10 copies of the last element
rep(x, times=c(4,2,3,1,10))
# or 50 copies of the last element:
rep(x, times=c(4,2,3,1,50))

# if the "times" parameter is just 1 number, 
# then we get a different effect, namely,
# we get the whole vector repeated, that number of times,
# consecutively, e.g., x repeated 3 times:
rep(x, times=3)

# similarly, if I want 3 copies of each element, together,
rep(x, each=3)
# this has the exact same effect as
rep(x, times=c(3,3,3,3,3))

# can also use the length parameter;
# this gives us a recycled version of x, of length 13 total:
rep(x, length=13)
