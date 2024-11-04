# examples with terrain.colors, topo.colors, etc
plot( rnorm(10000), col=terrain.colors(10000))
plot( rnorm(10000), col=topo.colors(10000))
plot( rnorm(10000), col=rainbow(10000))

?terrain.colors

# another example is to grey's or gray's
?gray
plot( rnorm(10000), col=grey(seq(0,.9999,by=.0001)))

# other ways to generate colors, for instance,
?colorRampPalette

# practice colors in R, try several ways, see what happens!

