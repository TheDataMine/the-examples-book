# factorial function, i.e., for instance 10!
factorial(10)
# same thing as:
#1*2*...*10
# check:
prod(1:10)

# smaller numbers might be more familiar, e.g.,
# 1 * 2 * 3 * 4 * 5:
1 * 2 * 3 * 4 * 5
factorial(5)

# also R has binomial numbers, for instance,
# "5 choose 2", i.e., 5! / (2! * 3!) we can write:
choose(5, 2)
# same thing, but longer to write:
(factorial(5))/(factorial(2) * factorial(3))

# cumulative summation:
?cumsum

v <- c(3,5,19,4,4,4,10)
cumsum(v)
# first entry is just 3
# second entry is 3 + 5 = 8
# third entry is 3 + 5 + 19 = 27
# fourth entry is 3 + 5 + 19 + 4 = 31
# fifth entry is 3 + 5 + 19 + 4 + 4 = 35
# and so on
# i.e., the nth entry is the sum of the first n entries

# also a cumulative product:
cumprod(v)
# first entry is just 3
# second entry is 3 * 5 = 15
# third entry is 3 * 5 * 19 = 285
# fourth entry is 3 * 5 * 19 * 4 = 1140
# fifth entry is 3 * 5 * 19 * 4 * 4 = 4560
# and so on
# i.e., the nth entry is the product of the first n entries

# to find the biggest entry so far in the vector:
v
cummax(v)
v <- c(v, 23, 27, 20, 25, 30)
v
cummax(v)
# cummax just keeps track, entry by entry,
# of the biggest values seen so far

# similar things work for cummin
