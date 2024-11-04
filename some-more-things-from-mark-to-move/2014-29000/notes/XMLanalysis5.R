#  How to scrape data from the web and then parse it.
#  Example 5

# Here are even some more examples about parsing XML

library("XML")

# The original data is found at:
  http://www.w3schools.com/XPath/xpath_examples.asp
# You can also download it from llc at:
  http://llc.stat.purdue.edu/2014/29000/notes/bookexample.xml
# You can save it to your home directory on llc.
# The following command will save the XML code from the file
# into the variable called mydoc

mydoc <- xmlInternalTreeParse("bookexample.xml")

#  We use some of the XPath code
#  which is discussed in Chapter 6 of the Learning XML book:
#  Learning XML, 2nd Edition, by Erik T. Ray (O'Reilly, 2003)
#  http://proquestcombo.safaribooksonline.com.ezproxy.lib.purdue.edu/0596004206

#First we select all titles of all the books:
  
xpathSApply(mydoc, "/bookstore/book/title", xmlValue)

# we can select just the second book's title

xpathSApply(mydoc, "/bookstore/book[2]/title", xmlValue)

# we can select the price of each book

xpathSApply(mydoc, "/bookstore/book/price", xmlValue)

# we can modify this so that we get the price in numeric format
# The following line is trouble; it does not do what we expect:

xpathSApply(mydoc, "/bookstore/book/price", as.numeric(xmlValue) )

# This is better:

xpathSApply(mydoc, "/bookstore/book/price", function(x) as.numeric(xmlValue(x)) )

# we can get the prices of all books that cost more than 30

xpathSApply(mydoc, "/bookstore/book[price>30]/price", xmlValue)

# or the prices of all books that cost 30 or more

xpathSApply(mydoc, "/bookstore/book[price>=30]/price", xmlValue)

# the following looks messy because we are selecting internal
# nodes of the tree instead of a leaf node
# so all of the data gets lumped together in a messy-looking way:

xpathSApply(mydoc, "/bookstore/book[price>=30]", xmlValue)

# we can get the title of each book that costs 30 or more

xpathSApply(mydoc, "/bookstore/book[price>=30]/title", xmlValue)

# we can get a node for each book, but as before, these are
# internal nodes, so the result looks somewhat messy

xpathSApply(mydoc, "/bookstore/book", xmlValue)

# the following gives all of the children of the book nodes:

xpathSApply(mydoc, "/bookstore/book/child::node()", xmlValue)

# here are the authors of all the books;
# notice that the authors are not separated by their individual books:

xpathSApply(mydoc, "/bookstore/book/author", xmlValue)

# here are all of the nodes that are found two levels below
# the bookstore node in the XML tree

xpathSApply(mydoc, "/bookstore/*/*/self::node()", xmlValue)

# here are the children of the book written by J K. Rowling

xpathSApply(mydoc, "/bookstore/book[author='J K. Rowling']/child::node()", xmlValue)

# here are the nodes of the children of the books
# that are found before J K. Rowling's book in the list

xpathSApply(mydoc, "/bookstore/book[author='J K. Rowling']/preceding-sibling::*/child::node()", xmlValue)

# here are the nodes of the children of the books 
# that are found after J K. Rowling's book in the list

xpathSApply(mydoc, "/bookstore/book[author='J K. Rowling']/following-sibling::*/child::node()", xmlValue)

# here are the nodes of the children of the books 
# that are found after Giada De Laurentiis's book in the list

xpathSApply(mydoc, "/bookstore/book[author='Giada De Laurentiis']/following-sibling::*/child::node()", xmlValue)

# here are the authors of the books 
# that are found after Giada De Laurentiis's book in the list

xpathSApply(mydoc, "/bookstore/book[author='Giada De Laurentiis']/following-sibling::*/author", xmlValue)

# here are the authors of the children's books 
# that are found after Giada De Laurentiis's book in the list

xpathSApply(mydoc, "/bookstore/book[author='Giada De Laurentiis']/following-sibling::*[@category='CHILDREN']/author", xmlValue)

# here are the authors of the WEB books 
# that are found after Giada De Laurentiis's book in the list

xpathSApply(mydoc, "/bookstore/book[author='Giada De Laurentiis']/following-sibling::*[@category='WEB']/author", xmlValue)

# here are the nodes of the children of the books
# that are written by J K. Rowling

xpathSApply(mydoc, "/bookstore/book[author='J K. Rowling']/child::node()", xmlValue)

# here are the nodes of the children of the books
# that are not written by J K. Rowling

xpathSApply(mydoc, "/bookstore/book[not(author='J K. Rowling')]/child::node()", xmlValue)

# here are the nodes of the children of the 3rd book

xpathSApply(mydoc, "/bookstore/book[3]/child::node()", xmlValue)

# here are the nodes of the children for all books except the third book

xpathSApply(mydoc, "/bookstore/book[position()!=3]/child::node()", xmlValue)

# here are the node of the children for all books that are WEB books

xpathSApply(mydoc, "/bookstore/book[@category='WEB']/child::node()", xmlValue)



