install.packages("ggmap")
library(ggmap)
myDF <- read.csv("/depot/statclass/data/taxiexample.csv")
mypoints <- data.frame(lon=myDF$pickup_longitude,lat=myDF$pickup_latitude)
nyc_center = as.numeric(geocode("New York City"))
NYCMap = ggmap(get_googlemap(center=nyc_center,zoom=12), extent="normal")
# or if Google maps fails to provide the geocode, we can provide the latitude and longitute manually as follows:
NYCMap = ggmap(get_googlemap(center=c(-73.9926,40.74218),zoom=12), extent="normal")
NYCMap <- NYCMap + geom_point(data=mypoints)
NYCMap

