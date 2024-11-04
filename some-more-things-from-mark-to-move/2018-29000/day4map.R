# We install the ggmap package
# This only needs to be done ONE TIME.
install.packages("ggmap")

# We load the ggmap.  This needs to be done every time.
library(ggmap)

# At the risk of appearing to utilize another person's idea,
# I wanted to point out that I saw the idea of plotting
# the New York City taxi cab data using ggplot somewhere
# on the web and I don't remember where.  I have searched
# and searched and can't quite find where I got this idea
# originally.  I apologize for not remembering where I
# first saw this idea!

# Now we load the first several lines of a file
# that contains some of the taxi cab rides from NYC.
myDF <- read.csv("/depot/statclass/data/taxiexample.csv")

# Here are the first 6 lines of this file:
head(myDF)
# and the dimensions of the file:
dim(myDF)

# These are the longitudes and latitudes:
myDF$pickup_longitude
myDF$pickup_latitude

# We can easily sort the longitude and latitude for instance.
sort(myDF$pickup_longitude)
sort(myDF$pickup_latitude)

# Now we build a new data.frame containing
# the longitudes and latitudes.
mypoints <- data.frame(lon=myDF$pickup_longitude,lat=myDF$pickup_latitude)

# In preparation for making a map,
# we get the center of New York City from Google:
nyc_center = as.numeric(geocode("New York City"))
# Then we build a map of New York
NYCMap = ggmap(get_googlemap(center=nyc_center,zoom=12), extent="normal")
# and we display it.

# or if Google maps fails to provide the geocode, we can provide the latitude and longitute manually as follows:
NYCMap = ggmap(get <- googlemap(center=c(-73.9926,40.74218),zoom=12), extent="normal")

# Either way, we are ready to display the map now:
NYCMap

# Finally, we add the points to the map
NYCMap <- NYCMap + geom_point(data=mypoints)
# and we display the map again.
NYCMap

