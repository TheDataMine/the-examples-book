#  How to scrape data from the web and then parse it.
#  Example 4

# We present some more examples about how to use XPath statements
# to find the parts of an XML file that we want to extract.

library("XML")

# The following example is an introduction to XPath
# which can be used for traversing an XML tree in a natural way.
# The original data is found at:
  http://www.w3schools.com/xml/cd_catalog.xml
# You can also download it from llc at:
  http://llc.stat.purdue.edu/2014/29000/notes/cd_catalog.xml
# You can save it to your home directory on llc.
# The following command will save the XML code from the file
# into the variable called mydoc

library(XML)
mydoc <- xmlRoot(xmlTreeParse("cd_catalog.xml"))

# You can also load this data directly from the web by:
  
mydoc <- xmlRoot(xmlTreeParse("http://llc.stat.purdue.edu/2014/29000/notes/cd_catalog.xml"))

# Each child of the root contains information about a different song

mydoc[[1]]
mydoc[[2]]
mydoc[[3]]
mydoc[[4]]

# There are 26 songs altogether

length(mydoc)

# One very nice aspect of XML with useful names for the tags
# is that we can refer to the data by its name, for instance
# we can get the price of the 4th album as follows,
# first finding where the value is located, and then extracting the xmlValue, and
# finally converting from a character string to a numeric value:
  
mydoc[[4]]$children
mydoc[[4]]$children$PRICE
xmlValue(mydoc[[4]]$children$PRICE)
as.numeric(xmlValue(mydoc[[4]]$children$PRICE))

# We can write a little function to get the price of the nth album:
  
pricefunc <- function(n) as.numeric(xmlValue(mydoc[[n]]$children$PRICE))

# For example, here is how the function can be used to get the price of the 15th album:
pricefunc(15)

# and then we can get the prices for all of the albums, with an sapply function:

sapply(1:26, pricefunc)

# We could have done this without defining a separate function:
  
sapply( 1:26, function(n) as.numeric(xmlValue(mydoc[[n]]$children$PRICE)) )

# For instance, here is a way to get the years of all the albums

sapply( 1:26, function(n) as.numeric(xmlValue(mydoc[[n]]$children$YEAR)) )

########################################

#Now we use XPath to parse the document, instead of parsing the tree ourselves directly.
# The XPath is more powerful but takes some time to learn.

# We must begin by using a different function to get the XML code:
  
mydoc <- xmlInternalTreeParse("cd_catalog.xml")

# Then we use a function called getNodeSet to get the relevant
# parts of the XML tree with the code that we are interested in

?getNodeSet

# here is the entire catalog:
  
getNodeSet(mydoc, "//CATALOG")

# here are the nodes for the separate albums:
  
getNodeSet(mydoc, "//CATALOG/CD")

# here are the nodes for the prices:
  
getNodeSet(mydoc, "//CATALOG/CD/PRICE")

# we can extract the xmlValues of each price:
  
sapply(getNodeSet(mydoc, "//CATALOG/CD/PRICE"),xmlValue)

# instead of using the function xmlValue on each node,
# we could use function(x) as.numeric(xmlValue(x))
# so that we directly extract the numeric value of each price

sapply(getNodeSet(mydoc, "//CATALOG/CD/PRICE"),function(x) as.numeric(xmlValue(x)) )

# there is a function to combine the sapply and the getNodeSet
# called:  xpathSApply
# so we can revise our code above as follows:
  
xpathSApply(mydoc, "//CATALOG/CD/PRICE", xmlValue)

xpathSApply(mydoc, "//CATALOG/CD/PRICE", function(x) as.numeric(xmlValue(x)) )

# the xpathSApply command first uses an XPath,
# and get applies a function, which is often an xmlValue function,
# to extract the relevant values

?xpathSApply

