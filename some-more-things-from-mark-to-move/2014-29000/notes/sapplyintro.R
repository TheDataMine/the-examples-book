#Here are some examples of the sapply function:

sapply( 1:10, sqrt )
#is just like
sqrt(1:10)

sapply(1:10, function(x){ x^2 })
#is just like
(1:10)^2

sapply( seq(0, 360, by=22.5), sin )
#is just like
sin( seq(0,360,by=22.5) )

sapply( 1:10, function(x){ x^3 + 17*x^2 + 32*x + 5 } )
#is just like
(1:10)^3 + 17*(1:10)^2 + 32*(1:10) + 5
#BUT, MOREOVER, the sapply version has the benefit that,
#if we want to change (say) 1:10 to 1:100, we only
#need to change it once, not three times.

#Now consider
sapply( list( 1:10, 50:55, 70:82 ), mean )
#which takes a mean of the sequence 1:10
#and takes a mean of the sequence 50:55
#and takes a mean of the sequence 70:82

#On the other hand,
sapply( c( 1:10, 50:55, 70:82 ), mean )
#will make c(1:10, 50:55, 70:82) into one longer vector,
#and then sapply will take a mean of each component, i.e., of each individual number,
#which is not what we intended at all.  That's why we use list and not c.
