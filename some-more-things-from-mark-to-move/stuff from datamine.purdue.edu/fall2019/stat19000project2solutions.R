# We install the ggmap package
# This only needs to be done ONE TIME.
# You will not need to do this again.
install.packages("ggmap")

# We load the ggmap library.
library(ggmap)

# Now we load the information from the AirBnB data
# for the city of London.
myDF <- read.csv("/class/datamine/data/airbnb/united-kingdom/england/london/2019-07-10/visualisations/listings.csv")

# Now we build a new data.frame containing
# only the longitudes and latitudes.
mypoints <- data.frame(lon=myDF$longitude,lat=myDF$latitude)

# We use Dr Ward's Google API key,
# so that we are able to load maps in Google.
register_google(key = "AIzaSyDYnLiu1jyxvo4hYqZJqqyZM7kx2fCpUls", write = TRUE)

# In preparation for making a map,
# we get the center of London from Google:
london_center = as.numeric(geocode("London"))
# Then we build a map of London
LondonMap <- ggmap(get_googlemap(center=london_center,zoom=10))
# Finally, we add the points to the map
LondonMap <- LondonMap + geom_point(data=mypoints, size=0.1)
# and we display the map.
LondonMap
