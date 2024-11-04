v <- seq(as.Date("1958-08-02"), as.Date("2018-10-20"), by = "week")
head(v)
tail(v)
length(v)
class(v)
mydates
mydates <- tail(as.character(v))
# remove the "tail" from the line above,
# if you want to download all of the weeks!
mycommands <- paste("curl https://www.billboard.com/charts/hot-100/", mydates, " >", mydates, sep="")
mycommands

sapply(mycommands, system, ignore.stderr = TRUE)

install.packages("XML")
library(XML)

mydoc <- htmlParse("1976-10-16")
mysongs <- xpathSApply(mydoc, "//*/div[@class='chart-list-item__title']|//*/div[@class='chart-number-one__title']", xmlValue)
mysongs
mysongs <- sub("^\\s+", "", mysongs)
mysongs <- sub("\\s+$", "", mysongs)
mysongs

myartists <- xpathSApply(mydoc, "//*/div[@class='chart-list-item__artist']|//*/div[@class='chart-number-one__artist']", xmlValue)
myartists
myartists <- sub("^\\s+", "", myartists)
myartists <- sub("\\s+$", "", myartists)
myartists

length(mysongs)
length(myartists)

allmysongs <- sapply(as.character(v), function(x) {
  mydoc <- htmlParse(x)
  mysongs <- xpathSApply(mydoc, "//*/div[@class='chart-list-item__title']|//*/div[@class='chart-number-one__title']", xmlValue)
  mysongs <- sub("^\\s+", "", mysongs)
  mysongs <- sub("\\s+$", "", mysongs)
  mysongs})

length(allmysongs)

allmyartists <- sapply(as.character(v), function(x) {
  mydoc <- htmlParse(x)
  myartists <- xpathSApply(mydoc, "//*/div[@class='chart-list-item__artist']|//*/div[@class='chart-number-one__artist']", xmlValue)
  myartists <- sub("^\\s+", "", myartists)
  myartists <- sub("\\s+$", "", myartists)
  myartists})

length(allmyartists)



