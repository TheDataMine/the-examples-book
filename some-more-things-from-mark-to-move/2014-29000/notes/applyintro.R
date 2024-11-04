#How to use the apply function:

# We can take a function along each column of a matrix,
# for instance, here we take an average of each column
# of the state.x77 matrix:
apply(state.x77, MARGIN=2, mean)

# or we could take the variance of each column:
apply(state.x77, MARGIN=2, var)

# or the standard deviation:
apply(state.x77, MARGIN=2, sd)

# we could also take the maximum of each column:
apply(state.x77, MARGIN=2, max)

# the MARGIN parameter is used to establish
# which dimension the function is applied to

# for instance, we used MARGIN=2 because we wanted to
# apply a function to each column of a matrix

# we could use MARGIN=1 if we want to apply a function
# to each row of a matrix

# we can do similar things for arrays as well,
# as we can use MARGIN=3 or higher for arrays that
# have 3 or more dimensions.

