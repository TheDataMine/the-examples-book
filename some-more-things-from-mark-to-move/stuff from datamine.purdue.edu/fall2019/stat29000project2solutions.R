#3a.
# We load the ggmap library.
library(ggmap)

mymapfunction <- function(mylon,mylat,mycenter,myzoom) {
  mypoints <- data.frame(lon=mylon,lat=mylat)
  register_google(key = "AIzaSyDYnLiu1jyxvo4hYqZJqqyZM7kx2fCpUls", write = TRUE)
  mymapcenter = as.numeric(geocode(mycenter))
  mymap <- ggmap(get_googlemap(center=mymapcenter,zoom=myzoom))
  mymap <- mymap + geom_point(data=mypoints, size=0.1)
  mymap
}

#3b.
# Now we load the information from the AirBnB data
# for the city of Los Angeles.
myDF <- read.csv("/class/datamine/data/airbnb/united-states/ca/los-angeles/2019-07-08/visualisations/listings.csv")
# and we make the map
mymapfunction(myDF$longitude,myDF$latitude,"Los Angeles",9)

#3c.
# Now we load the information from the AirBnB data
# for the city of London.
myDF <- read.csv("/class/datamine/data/airbnb/united-kingdom/england/london/2019-07-10/visualisations/listings.csv")
# and we make the map
mymapfunction(myDF$longitude,myDF$latitude,"London",10)

# Just for one more example of using the map:

# Now we load the information from the AirBnB data
# for the city of Paris.
myDF <- read.csv("/class/datamine/data/airbnb/france/ile-de-france/paris/2019-07-09/visualisations/listings.csv")
# and we make the map
mymapfunction(myDF$longitude,myDF$latitude,"Paris",12)

