# This is a short project to download the data about the
# properties in the National Park Service (NPS).
# They are all online through the office NPS webpage:
#   https://www.nps.gov/findapark/index.htm
# (Please note that some parks extend into more than one state.)

# At the end of the project, when we export the data,
# we do not want to use comma-separated values (i.e., a csv file)
# because there are also some commas in our data.
# So we will use tabs as our delimiter at the end of this process.

# We will use the RCurl package to download the NPS files.
# Normally we could just parse the XML (or html) content
# on-the-fly, without downloading the files, but in this case,
# it wasn't working on about 10 of the files, and somehow
# when I downloaded the files, it worked completely.
# I tried this several times, and just going ahead and downloading
# the files seems to be the most consistent solution.
install.packages("RCurl")
library(RCurl)

# We will use the XML package to parse the html (or XML) data
install.packages("XML")
library(XML)

# We will use the xlsx package to export the results at the end,
# into an xlsx file, for viewing in Microsoft Excel, if desired.
install.packages("xlsx")
library(xlsx)

# To see the list of the parks, we can go here:
#    https://www.nps.gov/findapark/index.htm
# in any browser.
# In most browsers, if you navigate to a page and then type:
# Control-U (i.e., the Control Key and the letter U Key at once)
# on a Windows or UNIX machine,
# or if you type Command-U (i.e., the Command Key and the letter U Key at once)
# on an Apple Macintosh machine,
# then you can see the code for the way that the webpage is created.

# This webpage that I mentioned:
#    https://www.nps.gov/findapark/index.htm
# has 1543 lines of code.  Wow.


# From (roughly) lines 206 through 756, we see that the
# data for the parks are wrapped in a "div" (on line 206)
# and then in a "select" (on line 208)
# and then in an "optgroup" and then an "option".
# We want to extract the "value" of each "option".
# (We skip the "label" on line 205 because it ends on line 205 too.)
# So we do the following:

myparks <- xpathSApply(htmlParse(getURL("https://www.nps.gov/findapark/index.htm")), "//*/script", , "value")
myparks

# If the line of code (above) doesn't work,
# then perhaps you forgot to actually run the three "library" commands
# near the start of the file.

# We did a lot of things with 1 line of code.
# The "getURL" temporarily downloads all of the code from this webpage.
# We do not save the webpage, but rather, we send it to the htmlParse command.
# Once the page is parsed, we send the parsed results to the xpathSApply command.
# The pattern we want to look for is:
#    "//*/div/select/optgroup/option"
# The star means that anything is OK before this chunk of the pattern,
# but we definitely want our pattern to end with /div/select/optgroup/option
# and then we get the xmlGetAttr attribute called "value"
# which is one of the parks.

# When we check the results, we got 497 results:
length(myparks)

# For the Abraham Lincoln Birthplace, we want to run the following command,
# so that we are prepared to download the webpage.
# After downloading it, we will extract information from the parsed page:
download.file("https://www.nps.gov/abli/index.htm", "~/Desktop/abli.htm")
htmlParse("~/Desktop/abli.htm")

# but we want to do that for each park.
# So we build the following function:
myparser <- function(x) {
  download.file(paste("https://www.nps.gov/", x, "/index.htm", sep=""), paste("~/Desktop/", x, ".htm", sep=""))
  htmlParse(paste("~/Desktop/", x, ".htm", sep=""))
}

# Now, we apply this function to each element of "myparks"
# and we save the results in a variable called "mydocs":
mydocs <- sapply(myparks, myparser)

# The webpage for the Abraham Lincoln Birthplace is now parsed and stored here:
mydocs[[1]]
# The webpage for Zion National Park is now parsed and stored here:
mydocs[[497]]

# Next we look at the source for the Abraham Lincoln Birthplace:
#   https://www.nps.gov/abli/index.htm
# We load that webpage in any browser and then type:
# Control-U if we are on a Windows or UNIX machine, or
# Command-U if we are on a Mac.

# Then we can search in this page (using Control-F on Windows or UNIX,
# or using Command-F on a Mac) for any pattern we want.
# If we search for "itemprop"
# we find the information about the address:

# They are all within a "span" tag, with different "itemprop" attributes:
# The street address has attribute: "streetAddress"
# The city has attribute: "addressLocality"
# The state has attribute: "addressRegion"
# The zip code has attribute: "postalCode"
# The telephone has attribute: "telephone"

# So, for instance, we can find all of these as follows:
xpathSApply(mydocs[[1]], "//*/span[@itemprop='streetAddress']", xmlValue)
xpathSApply(mydocs[[1]], "//*/span[@itemprop='addressLocality']", xmlValue)
xpathSApply(mydocs[[1]], "//*/span[@itemprop='addressRegion']", xmlValue)
xpathSApply(mydocs[[1]], "//*/span[@itemprop='postalCode']", xmlValue)
xpathSApply(mydocs[[1]], "//*/span[@itemprop='telephone']", xmlValue)

# Then the title stuff:

xpathSApply(mydocs[[1]], "//*/div[@id='HeroBanner']/div/div/div/a", xmlValue)
xpathSApply(mydocs[[1]], "//*/span[@class='Hero-designation']", xmlValue)
xpathSApply(mydocs[[1]], "//*/span[@class='Hero-location']", xmlValue)

# and, finally, the social media links:

paste(xpathSApply(mydocs[[1]], "//*/div/ul/li[@class='col-xs-6 col-sm-12 col-md-6']/a", xmlGetAttr, "href"),collapse=",")


# Here are the versions for the entire data set:

streets <- sapply(mydocs, function(x) xpathSApply(x, "//*/span[@itemprop='streetAddress']", xmlValue))
cities <- sapply(mydocs, function(x) xpathSApply(x, "//*/span[@itemprop='addressLocality']", xmlValue))
states <- sapply(mydocs, function(x) xpathSApply(x, "//*/span[@itemprop='addressRegion']", xmlValue))
zips <- sapply(mydocs, function(x) xpathSApply(x, "//*/span[@itemprop='postalCode']", xmlValue))
phones <- sapply(mydocs, function(x) xpathSApply(x, "//*/span[@itemprop='telephone']", xmlValue))

mynames <- sapply(mydocs, function(x) xpathSApply(x, "//*/div[@id='HeroBanner']/div/div/div/a", xmlValue))
mytypes <- sapply(mydocs, function(x) xpathSApply(x, "//*/span[@class='Hero-designation']", xmlValue))
mylocations <- sapply(mydocs, function(x) xpathSApply(x, "//*/span[@class='Hero-location']", xmlValue))

mylinks <- sapply(mydocs, function(x) paste(xpathSApply(x, "//*/div/ul/li[@class='col-xs-6 col-sm-12 col-md-6']/a", xmlGetAttr, "href"),collapse=","))

# with some cleaning up:

streets <- sapply(streets, function(x) ifelse(length(x)==0,NA,sub("^\\s+","",sub("\\s+$","",x))), simplify=FALSE)
cities <- sapply(cities, function(x) ifelse(length(x)==0,NA,sub("^\\s+","",sub("\\s+$","",x))), simplify=FALSE)
states <- sapply(states, function(x) ifelse(length(x)==0,NA,sub("^\\s+","",sub("\\s+$","",x))), simplify=FALSE)
zips <- sapply(zips, function(x) ifelse(length(x)==0,NA,sub("^\\s+","",sub("\\s+$","",x))), simplify=FALSE)
phones <- sapply(phones, function(x) ifelse(length(x)==0,NA,sub("^\\s+","",sub("\\s+$","",x))), simplify=FALSE)
mynames <- sapply(mynames, function(x) ifelse(length(x)==0,NA,sub("^\\s+","",sub("\\s+$","",x))), simplify=FALSE)
mytypes <- sapply(mytypes, function(x) ifelse(length(x)==0,NA,sub("^\\s+","",sub("\\s+$","",x))), simplify=FALSE)
mylocations <- sapply(mylocations, function(x) ifelse(length(x)==0,NA,sub("^\\s+","",sub("\\s+$","",x))), simplify=FALSE)
mylinks <- sapply(mylinks, function(x) ifelse(length(x)==0,NA,sub("^\\s+","",sub("\\s+$","",x))), simplify=FALSE)

myDF <- data.frame(
streets=do.call(rbind,streets),
cities=do.call(rbind,cities),
states=do.call(rbind,states),
zips=do.call(rbind,zips),
phones=do.call(rbind,phones),
mynames=do.call(rbind,mynames),
mytypes=do.call(rbind,mytypes),
mylocations=do.call(rbind,mylocations),
mylinks=do.call(rbind,mylinks)
)

write.xlsx(myDF, "myNPS.xlsx")

??xlsx

