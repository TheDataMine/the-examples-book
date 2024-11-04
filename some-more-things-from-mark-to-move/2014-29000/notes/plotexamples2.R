# a few more plot examples,
# where we export the results to a file

# we can, for instance, export several pictures to several files
# the default is to send everything to one file
# but we can change the default by setting onefile=FALSE

# when we make the file names, we can make them in a generic way,
# for instance,
pdf(onefile=FALSE, file="mynewfile%03d.pdf")
# looks a little strange, but the %03d means to leave 3 decimal places for numbers in the file names.
# now let us go and make some plots
example(barplot)  # this one actually creates 10 pdf files as output!
plot(pressure)
plot(rnorm(20))
dev.off()   # turn off the plotting device

# we can send output to sources other than pdf files, for instance,
# we can send output to a jpg file:
jpeg("mynewpicture.jpg")
plot(pressure)
dev.off()

# other example file output types we can use include:
# postscript(), pictex(), xfig(), bitmap(), png(), win.metafile(), bmp(), etc.....


