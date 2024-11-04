#  How to scrape data from the web and then parse it.
#  Example 1

#  We use RCurl to retrieve data from the web.
install.packages("RCurl")
library(RCurl)

#  We can import the information from a URL directly into R,
#  by saving the address as a file name, and then using getURL to retrieve the data.
myurl <- "http://espn.go.com/mlb/player/stats/_/id/3246"
mydata <- getURL(myurl)

#  It is very common to save such data into our computer before parsing it.
#  We first give it a file name, and then write the data to the file:
myfilename <- "jeter.html"
writeLines(mydata, myfilename)

#  We close the file when we are done writing it:
close(file(myfilename))

#  Then we use the XML library to parse the file:
install.packages("XML")
library(XML)

mydoc <- htmlParse(myfilename)
myresult <- xpathSApply(mydoc, "//*/td[@class='textright']/child::text()", xmlValue)

#  So we have all of Derek Jeter's statistics saved into a vector of data now:
myresult

#  It is not formatted, but we will study more details about how to use XPath
#  so that we can read in some data in a very structured way.



