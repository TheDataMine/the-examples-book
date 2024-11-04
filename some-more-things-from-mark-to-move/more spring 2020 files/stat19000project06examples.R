# Examples of using R to analyze XML:
# https://www.tutorialspoint.com/r/r_xml_files.htm
# https://lecy.github.io/Open-Data-for-Nonprofit-Research/Quick_Guide_to_XML_in_R.html

# Good resources to read up on XPath and XML:
# https://librarycarpentry.org/lc-webscraping/02-xpath/index.html
# https://www.w3schools.com/xml/xpath_intro.asp

# As in project 5, we will continue to use R packages XML and xml2.
# Find some useful resources/documentation on the packages below:
# xml2: https://xml2.r-lib.org/
# XML: http://www.omegahat.net/RSXML/shortIntro.pdf
# xml2 <-> XML: https://gist.github.com/nuest/3ed3b0057713eb4f4d75d11bb62f2d66

# Let's start with XML
# (and then we will repeat the examples using xml2 + xmltools)
library(XML)

# We will look at ACM SIGMOD. You can find more information on this data here https://www.dia.uniroma3.it/Araneus/Sigmod/
dat_XML <- xmlParse("http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/sigmod-record/SigmodRecord.xml", asTree=T)

# Remember, XML can store data in a tree-type structure,
# including the root node and (several layers of) children nodes.
# Data are stored in each node in terms of node names and values.

# Getting the root
dat_root_XML <- xmlRoot(dat_XML)

# Root's name
xmlName(dat_root_XML)

# Getting the root's children (issues )
issues <- xmlChildren(dat_root_XML)

# Let's look at an issue
issues[[1]]

# Based on the examples for project 5, to get the names of all the nodes in an issue
# we would use sapply on the children's nodes of issues[[1]]:
sapply(xmlChildren(issues[[1]]), xmlName)

# Another option is to use xmlApply and/or xmlSApply.
# xmlApply and xmlSApply already apply the function to all the children,
# so we do not need to specify that as we did before!
xmlSApply(issues[[1]], xmlName)

# We will now use XPath to explore the issues in our ACM SIGMOD data.
# XPath uses path expressions to select nodes or node-sets in an XML document.
# The node is selected by following a path or steps.
## "this_is_a_name" selects all nodes with the name "this_is_a_name"
## "/" selects from the root node
## "//"  selects nodes in the document from the current node that match the selection no matter where they are.
## If used at the beginning of a path, "//" will find the following node anywhere in the xml document.
## "." selects the current node
## ".." selects the parent of the current node
## "@" selects attributes
## "*" is a wildcard and will match anything where it is placed

# To better understand this, let's look at the function getNodeSet(),
# which helps us find XML nodes that match a particular criterion.
# For the first course listing, let's get the node with name "volume"
# which corresponds to the node with the volume number
getNodeSet(issues[[1]], "volume")

# Let's do it again but using "/", which means selecting from the root node.
# Remember that here the root is named 'SigmodRecord'.
# Note that if we run the code below we would get the titles of ALL volumes.
getNodeSet(issues[[1]], "/SigmodRecord/issue/volume")

# To give an example of *, let's say there are volume nodes in the following paths:
# /SigmodRecord/issue/volume
# /SigmodRecord/nonissue/volume
# /SigmodRecord/other/volume

# If we used "/SigmodRecord/*/volume", this would fetch every volume node
# at all of those locations because * matches anything! Cool. Let's say
# you wanted all of the nodes in all of the locations: issues, nonissues, and other.
# All you would need to do is "/SigmodRecord/*/*". You can mix and match as needed,
# it is very useful.

# To get the first one
getNodeSet(issues[[1]], "(/SigmodRecord/issue/volume)[1]")

# "(//volume)[1]" looks for the volume node and returns the first one from anywhere.
# See below some examples
getNodeSet(issues[[1]], "(//volume)[1]")
getNodeSet(issues[[44]], "(//volume)[1]")
getNodeSet(dat_root_XML, "(//volume)[1]")

# "." and ".." work similarly to what you are used to when reading files.
# Getting the volume number for the 44th issue from different nodes
getNodeSet(issues[[44]], "./volume")
getNodeSet(issues[[1]], "(../issue/volume)[44]")

# If at this stage you are confused about what role the first argument to
# getNodeSet plays, I like to think of the path (the second argument) as
# having precedence over the first argument. So in this example:

getNodeSet(issues[[1]], "/SigmodRecord/issue/volume")

# or this example:

getNodeSet(issues[[2]], "/SigmodRecord/issue/volume")

# We are giving the exact path we want, starting all the way from the root.
# So we will get all nodes that are named volume that are inside an issue
# that are within node SigmodRecord -- regardless of the exact node we are
# at/from.

# Thinking of it kind of like the `ls` command in bash. We could be in the
# home directory and run `ls ~/some/path`, but it won't return the files in the
# home directory, but it will return the files in `~/some/path`, not in `~/`.
# Similarly, we can be in any folder (node) and run `ls ~/some/path` and it
# will still return based on the path argument, not the folder I'm in
# (default argument). So in the sense of the original example:

getNodeSet(issues[[1]], "/SigmodRecord/issue/volume")

# the first argument doesn't matter except for the class/document,
# but in other scenarios (where the path depends on the start point
# (first argument), it does matter). Here are some more examples
# to think about if this is confusing:

getNodeSet(issues[[1]], "./volume")
getNodeSet(issues[[1]], "../issue/volume")
getNodeSet(issues[[1]][[3]], "./article") # issues[[1]][[3]] is articles node

# Looking at the first article in the first volume
getNodeSet(dat_root_XML, "(/SigmodRecord/issue/articles/article)[1]")

# In the node authors for the first issue, we have
#<authors>
#        <author position="00">Anthony I. Wasserman</author>
#        <author position="01">Karen Botnich</author>
#</authors>

# Position is the attribute's name in the node author, and has value 00
# for author value Anthony I. Wasserman and value 01 for Karen Botnich.
# Note the difference for: <author position="00">Anthony I. Wasserman</author>
# author is a node with attribue position. The node's value is Anthony I. Wasserman,
# and the attribute's value is 00.

# Let's get the first authors in all articles in the first issue.
# Note that to assess the attribute we used [] and @, and we
# were able to filter using the attribute ([@position<1] or [@position=0] works)
getNodeSet(issues[[1]], "./articles/article/authors/author[@position<1]")

# If we wanted the first author from the first article from the first issue
getNodeSet(issues[[1]], "(./articles/article/authors/author[@position=0])[1]")

# Getting all second authors for the first issue
getNodeSet(issues[[1]], "./articles/article/authors/author[@position=1]")

# Now that we understand a bit more about XPath expressions,
# let's pull some interesting information.
# We dealt with the apply function before. xpathApply and xpathSapply
# are logical extensions of them to deal with XML files.
# For example, you can use xpathSApply in the following way:

xpathSApply(YOUR_XML_DOC, "YOUR_XPATH_SYNTAX", YOUR_XML_FUNCTION)

# This will apply the function you specified (the third argument, YOUR_XML_FUNCTION)
# to all nodes that satisfy your xpath condition (the second argument, "YOUR_XPATH_SYNTAX")
# found in the XML data (the first argument, YOUR_XML_DOC).

# What are the names of all the first authors?
first_authors <- xpathSApply(dat_XML, "//author[@position=0]", xmlValue)

# What about the remaining authors?
# Even though the position attribute is a string, it can be and is coerced
# to a numeric type for comparison against 0, a numeric type.
other_authors <- xpathSApply(dat_XML, "//author[@position>0]", xmlValue)

# Is there an author that published more than once in our data?
# Here we don't want to have unique values for the authors, as having a repeat
# means that the author published more than once.
all_authors <- c(first_authors, other_authors)

# Table will help us get the frequencies, and we can see how many have appeared more than once
our_freq_table <- table(all_authors)
sum(our_freq_table>1)

# Let's make a plot
plot(our_freq_table, type='l')

# I don't like the xlabels
plot(our_freq_table, type='l', xaxt='n')

# Let's add a line that shows the 95th percentile
perc_95 <- quantile(our_freq_table, 0.95)
abline(h=perc_95, col='green')

# Let's sort the data and then plot
plot(sort(our_freq_table, decreasing=T), type='l', xaxt='n')

# What if we wanted to overlay another plot?
lines(sort(our_freq_table, decreasing=F), type='l', col='orange')

# How many authors have published in the 67 issues (xmlSize(dat_root_XML))?
length(unique(all_authors))

# Which author published the most?
which.max(our_freq_table)

# How many times did the author publish?
max(our_freq_table)

# Let's get all the articles published by him.
xpathSApply(dat_XML, "//article[authors/author='Michael J. Carey']/title", xmlValue)

# An important note here is that the square brackets [] can be used with @ for attributes. In
# this case, [authors/author='Michael J. Carey'] is a condition on the article node. In other
# words, we are only getting the title node, for all article nodes with an authors node that has
# an author node with the value 'Michael J. Carey'.

# To better understand this, if we had the following article node:

# <article>
#   <title>HODFA: An Architectural Framework for Homogenizing Heterogeneous Legacy Database.</title>
#   <initPage>15</initPage>
#   <endPage>20</endPage>
#   <authors>
#     <author position="00">
#       <firstName>Kamalakar</firstName>
#       <lastName>Karlapalem</lastName>
#       <age>20</age>
#     </author>
#     <author position="01">Qing Li
#       <firstName>Qing</firstName>
#       <lastName>Li</lastName>
#       <age>45</age>
#     </author>
#   </authors>
# </article>

# We could filter to match last name:
xpathSApply(dat_XML, "//article[authors/author/lastName='Li']/title", xmlValue)

# Or on age:
xpathSApply(dat_XML, "//article[authors/author/age>=25]/title", xmlValue)

# Another example on filtering based on a number:
length(xpathSApply(dat_XML, "//article[initPage <= 20]/title", xmlValue))
length(xpathSApply(dat_XML, "//article[initPage > 20]/title", xmlValue))
length(xpathSApply(dat_XML, "//article/title", xmlValue))

# You can access attributes using the @ sign, like we did earlier
# to find the non-first authors
xpathSApply(dat_XML, "//author[@position>0]", xmlValue)

# You can also have multiple conditions. Here, we are looking to make sure the
# author's position atribute has a value > 0 and the author value is 'Limsoon Wong'.
xpathSApply(dat_XML, "//authors[author/@position>0 and author='Limsoon Wong']", xmlValue)

# Let's now see how we would solve the examples above using xml2 instead.
library(xml2)

# Let's parse the data
dat_xml2 <- read_xml('http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/sigmod-record/SigmodRecord.xml')

# Getting the root
dat_root_xml2 <- xml_root(dat_xml2)

# Root's name
xml_name(dat_root_xml2)

# Getting the root's children (issues )
issues_xml2 <- xml_children(dat_root_xml2)

# Let's look at an issue
issues_xml2[[1]]

# Based on the examples for project 5, to get the names of all the nodes in an issue
# we would use sapply on the children's nodes of issues[[1]]:
sapply(xml_children(issues_xml2[[1]]), xml_name)

# Another option is to use xml_attrs and/or xml_contents
# Note the difference from the XML package: xmlSApply(issues[[1]], xmlName)
xml_name(xml_contents(issues_xml2[[1]]))

# getNodeSet() and xpathSApply() are replaced by xml_find_all and xml_find_first
xml_find_all(issues_xml2[[1]], "volume")

# There are many options for xml_find_*
?xml_find_all

# Using "/" instead. Remember that here the root is named 'SigmodRecord'
# Note that if we run the code below we would get the titles of ALL volumes.
xml_find_all(issues_xml2[[1]], "/SigmodRecord/issue/volume")

# To get the first one
xml_find_all(issues_xml2[[1]], "(/SigmodRecord/issue/volume)[1]")

# "(//volume)[1]" looks for the volume node and returns the first one from anywhere.
# See below some examples
xml_find_all(issues_xml2[[1]], "(//volume)[1]")
xml_find_all(issues_xml2[[44]], "(//volume)[1]")
xml_find_all(dat_root_xml2, "(//volume)[1]")

# Getting the volume number for the 44th issue from different nodes
xml_find_all(issues_xml2[[44]], "./volume")
xml_find_all(issues_xml2[[1]], "(../issue/volume)[44]")

# Looking at the first article in the first volume
xml_find_all(dat_root_xml2, "(/SigmodRecord/issue/articles/article)[1]")

# or..
xml_find_first(dat_root_xml2, "(/SigmodRecord/issue/articles/article)[1]")

# Getting first authors
# [@position=0] or [@position<1] would work for example.
xml_find_all(issues_xml2[[1]], "./articles/article/authors/author[@position=0]")

# if we wanted the first author from the first article from the first issue
xml_find_first(issues_xml2[[1]], "./articles/article/authors/author")

# Getting all second authors for the first issue
xml_find_all(issues_xml2[[1]], "./articles/article/authors/author[@position=1]")

# What are the names of all the first authors?
# Even though the position attribute is a string, it can be and is coerced
# to a numeric type for comparison against 0, a numeric type.
first_authors_xml2 <- xml_text(xml_find_all(dat_xml2, "//author[@position=0]"))

# What about the remaining authors?
other_authors_xml2 <- xml_text(xml_find_all(dat_xml2, "//author[@position>0]"))

# Is there an author that published in more than once in our data?
all_authors_xml2 <- c(first_authors_xml2, other_authors_xml2)

# Frequency table
our_freq_table_xml2 <- table(all_authors_xml2)
sum(our_freq_table_xml2>1)

# Let's make a plot
plot(our_freq_table, type='l')

# I don't like the xlabels
plot(our_freq_table, type='l', xaxt='n')

# Let's add a line that shows the 95th percentile
perc_95 <- quantile(our_freq_table, 0.95)
abline(h=perc_95, col='green')

# Let's sort the data and then plot
plot(sort(our_freq_table, decreasing=T), type='l', xaxt='n')

# What if we wanted to overlay another plot?
lines(sort(our_freq_table, decreasing=F), type='l', col='orange')

# How many authors have published in the 67 issues (xmlSize(dat_root_XML))?
length(unique(all_authors_xml2))

# Which author published the most?
which.max(our_freq_table_xml2)

# How many times did the author publish?
max(our_freq_table_xml2)

# Let's get all the articles published by him.
xml_text(xml_find_all(dat_xml2, "//article[authors/author='Michael J. Carey']/title"))

# An important note here is that the square brackets [] can be used with @ for attributes. In
# this case, [authors/author='Michael J. Carey'] is a condition on the article node. In other
# words, we are only getting the title node, for all article nodes with an authors node that has
# an author node with the value 'Michael J. Carey'.

# To better understand this, if we had the following article node:

# <article>
#   <title>HODFA: An Architectural Framework for Homogenizing Heterogeneous Legacy Database.</title>
#   <initPage>15</initPage>
#   <endPage>20</endPage>
#   <authors>
#     <author position="00">
#       <firstName>Kamalakar</firstName>
#       <lastName>Karlapalem</lastName>
#       <age>20</age>
#     </author>
#     <author position="01">Qing Li
#       <firstName>Qing</firstName>
#       <lastName>Li</lastName>
#       <age>45</age>
#     </author>
#   </authors>
# </article>

# We could filter to match last name:
xml_text(xml_find_all(dat_xml2, "//article[authors/author/lastName='Li']/title"))

# Or on age:
xml_text(xml_find_all(dat_xml2, "//article[authors/author/lastName='Li']/title"))

# Another example on filtering based on a number:
length(xml_text(xml_find_all(dat_xml2, "//article[initPage <= 20]/title")))
length(xml_text(xml_find_all(dat_xml2, "//article[initPage > 20]/title")))
length(xml_text(xml_find_all(dat_xml2, "//article/title")))

# You can access attributes using the @ sign, like we did earlier
# to find the non-first authors
xml_text(xml_find_all(dat_xml2, "//author[@position>0]"))

# You can also have multiple conditions. Here, we are looking to make sure the
# author's position atribute has a value > 0 and the author value is 'Limsoon Wong'.
xml_text(xml_find_all(dat_xml2, "//authors[author/@position>0 and author='Limsoon Wong']"))

# That's all folks!