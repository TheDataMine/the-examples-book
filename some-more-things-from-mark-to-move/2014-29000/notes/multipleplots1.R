# multiple plots on the same page,
# in a systematic way

# we can use parameters mfrow or mfcol
# these for filling in by row (or by column) the plots,
# in systematic rectangular regions

# example of mfrow:
par(mfrow=c(2,4))   # we will get 2 rows, 4 columns
curve(x^2)
curve(1-x^2)
curve(sin(x))
curve(cos(x))
curve(tan(x))
curve(x^3)
curve(2-x^5)
curve(x^4-1)

# mfcol is similar:
par(mfcol=c(2,3))
curve(1-x^2)
curve(tan(x))
curve(1-x^3)
curve(x^3)
curve(sin(x))
curve(cos(x))
