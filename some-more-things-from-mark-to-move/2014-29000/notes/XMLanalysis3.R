#  How to scrape data from the web and then parse it.
#  Example 3

# To better understand the tools for parsing XML,
# we do some simpler examples that show the way that the XML trees are structured.

library("XML")

#  There is some documentation for this XML package on the web;
#  see the documentation section of the official webpage:
#  http://www.omegahat.org/RSXML/
#  I will try to give some examples, to make this easier to understand.  

#  One of the main tools for parsing XML or HTML is xmlTreeParse
?xmlTreeParse

#  Download and save the examplegrades.xml file (it is exactly the same as the 
#  example from the omegahat website above).  You can download it from:
#  http://llc.stat.purdue.edu/2014/29000/notes/examplegrades.xml
#  (it appears on the calendar entry for the lecture today on the webpage).
#  For instance, I saved this example file in my home directory on llc.

#  Then parse the code from the file as follows:
xmlTreeParse("examplegrades.xml")

#  The xmlTreeParse command above will extract the XML code
#  and also some information about the XML document that we do not need.

#  We can view the XML code itself as a tree.
#  We can extract the information from the root of the tree as follows:
  
xmlRoot(xmlTreeParse("examplegrades.xml"))

#  We save this reference to the root of the tree in a variable called mydoc
#  (you could call it something else, if you prefer)
mydoc <- xmlRoot(xmlTreeParse("examplegrades.xml"))

# The first child of the root has the grades from Fred:

mydoc[[1]]

# The second child of the root has the grades from Wilma:
  
mydoc[[2]]

# The name Fred is stored as the first child of the first child:
  
mydoc[[1]][[1]]

# and we can get the value by typing:
  
xmlValue(mydoc[[1]][[1]])

# The grades for Fred are the second, third, and fourth children of the first child:
  
mydoc[[1]][[2]]
mydoc[[1]][[3]]
mydoc[[1]][[4]]

# and we can get the actual values of these grades (and remove the XML tags around them) by typing:
  
xmlValue(mydoc[[1]][[2]])
xmlValue(mydoc[[1]][[3]])
xmlValue(mydoc[[1]][[4]])

# but these are saved as character strings, so we want to convert to integers:
  
as.integer(xmlValue(mydoc[[1]][[2]]))
as.integer(xmlValue(mydoc[[1]][[3]]))
as.integer(xmlValue(mydoc[[1]][[4]]))

# Similarly, the name Wilma is found here:
  
mydoc[[2]][[1]]

# and the value is available by typing:
  
xmlValue(mydoc[[2]][[1]])

# and the grades for Wilma can be extracted as integers by typing

as.integer(xmlValue(mydoc[[2]][[2]]))
as.integer(xmlValue(mydoc[[2]][[3]]))
as.integer(xmlValue(mydoc[[2]][[4]]))

# We consider one more example.  The original data is found at:
  
  http://www.alistapart.com/d/usingxml/xml_uses_a.html

# I downloaded the data and saved it at:
  http://llc.stat.purdue.edu/2014/29000/notes/foodsample.xml

#You can download and save this file to your home directory on llc.

#The following command will save the XML code from the file into the variable called mydoc

mydoc <- xmlRoot(xmlTreeParse("foodsample.xml"))

# We see that there are 11 children of doc

length(mydoc)

# The first is a header

mydoc[[1]]

# and then children 2 through 11 correspond to specific foods:
  
mydoc[[2]]
mydoc[[3]]
mydoc[[4]]

# We can find the values of all parts of one of the children,
# for instance, the values of all of the children of the 3rd child:
  
xmlSApply(mydoc[[3]], xmlValue)

# One very helpful technique is to refer to a specific child by its name,
# using a notation similar to the notation that we used with data.frames.

xmlSApply(mydoc[[3]], xmlValue)$sodium

# We can convert this value to an integer

as.integer(xmlSApply(mydoc[[3]], xmlValue)$sodium)

# We can write a function to extract the sodium value from a specific food

sodiumfunc <- function(n) as.integer(xmlSApply(mydoc[[n]], xmlValue)$sodium)

# and then apply this function to each food, to get all of the sodium values:
  
sapply(2:11, sodiumfunc)
saltvector <- sapply(2:11, sodiumfunc)

# We can then view the data

plot(saltvector)

# We could also make a dotchart:
  
getfoodname <- function(n) xmlSApply(mydoc[[n]], xmlValue)$name
names(saltvector) <- sapply(2:11, getfoodname)
dotchart(saltvector)

# or display them in sorted order:
  
dotchart(sort(saltvector))

# or do anything else with the data that we want to do in R.

