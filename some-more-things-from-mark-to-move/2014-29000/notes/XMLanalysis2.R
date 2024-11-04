#  How to scrape data from the web and then parse it.
#  Example 2

#  We use RCurl to retrieve data from the web.
library(RCurl)

#  We can download the URL with the Yankees roster
myurl <- "http://espn.go.com/mlb/team/roster/_/name/nyy/new-york-yankees"
mydata <- getURL(myurl)

#  and then save this file:
myfilename <- "yankees.html"
writeLines(mydata, myfilename)

#  We close the file when we are done writing it:
close(file(myfilename))

#  Then we use the XML library to parse the file:
library(XML)
mydoc <- htmlParse(myfilename)

# This time we get the attributes from the href's:
myresult <- xpathSApply(mydoc, "//*/a", xmlGetAttr, "href")

#  So we have all of the Yankees URL's saved into a vector of data now:
myresult

#  We do not need most of these.  We unlist them, so that we get a character vector:
v <- unlist(myresult)
v

#  The ones we want have mlb/player/_/id in them; these are the indices of the ones we need:
grep("mlb/player/_/id/", v)

#  So here are the URL's:
myplayerurls <- v[grep("mlb/player/_/id/", v)]

#  We will need to extract the player names; here is how to do that:
mylist <-  strsplit( myplayerurls, "/" )
mynames <- sapply( mylist, function(x) {x[9]})
#  When we do it, in the function below, we will do it one name at a time.

#  Finally, we go back to the Deter Jeter example, and we build a function that lets us download the files:
getfiles <- function(myurl) {
  mydata <- getURL(myurl)
  myfilename <- paste( strsplit( myurl, "/")[[1]][9] , ".html", sep="")
  writeLines(mydata, myfilename)
  close(file(myfilename))
}

#  and we apply this function to each of the names in the mynames vector
sapply(myplayerurls, getfiles)

#  Check your current directory on llc now.  You will see that
#  you just downloaded 45 player files from the web
#  and saved each one into a separate file!




