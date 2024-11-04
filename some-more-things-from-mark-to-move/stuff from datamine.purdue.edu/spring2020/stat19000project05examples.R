# Good resources to read up on XML:
# https://beginnersbook.com/2018/10/xml-tutorial-learn-xml/
# https://www.sitepoint.com/really-good-introduction-xml/
# https://www.stoodq.com/xml
# https://www.hastac.org/blogs/deven/2017/01/19/xml-importance-applications

# More examples of XML:
# http://www-db.deis.unibo.it/courses/TW/DOCS/w3schools/xml/xml_examples.asp.html

# Examples of using R to analyze XML:
# https://www.tutorialspoint.com/r/r_xml_files.htm
        
# The first step is to install a package that can be used to work with XML.
# There are a variety of options: XML, xml2, flatxml, xmltools, etc
# In this project we will focus on XML and xml2 

# Here are some useful resources/documentation on the packages:
# xml2: https://xml2.r-lib.org/
# XML: http://www.omegahat.net/RSXML/shortIntro.pdf
# xml2 <-> XML: https://gist.github.com/nuest/3ed3b0057713eb4f4d75d11bb62f2d66
install.packages(c("XML",'xml2'),repos="http://cran.us.r-project.org")

# Let's start with XML (and then we will repeat the examples but using xml2)
library(XML)

# We will start by reading University of Wisconsin-Milwaukee course information from an xml
dat_XML <- xmlParse('http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/courses/uwm.xml', asTree=T)

# Let's make sure the class we have is related to XML
str(dat_XML)
class(dat_XML)

# XML can store data in a tree-type structure,
# including the root node and (several layers of) children nodes.
# Data are stored in each node in terms of node names and values. 

# Let's begin to explore our XML. First, we will look at the contents of the first node or root.
# We can get information such as the number of child nodes the root has, and their names.
# This is a way for us to check the entries we have in the XML file.
# Let's look at the UWM courses to get a better understanding of what we have.

# Getting the node (first node)
dat_root_XML <- xmlRoot(dat_XML)

# Let's see the structure of our node
str(dat_root_XML)

# Hmm, not much help...

# What is the name of the first node?
xmlName(dat_root_XML)

# The name 'root' is not very informative. How many children nodes does it have?
xmlSize(dat_root_XML)

# What's the name of the root's children?
xmlName(dat_root_XML[[1]])

# Note that we can also look at the root's first child by doing
dat_children_XML <- xmlChildren(dat_root_XML)
dat_children_XML[1]

# ...and the second child
dat_children_XML[2]

# Nice! So each child is a course_listing.
# Maybe an example of what information we have on each course listing would be more useful
dat_root_XML[[1]] # or dat_children_XML[1]

# We can do the same things for the root's children
xmlSize(dat_root_XML[[1]])

# Let's explore each of those 8 nodes, and get their names.
# Time to use the very useful sapply!
# There are (at least) two ways to do this.
# 1. We can use sapply as if we were doing a for loop for each i
sapply(1:8, function(i) xmlName(dat_root_XML[[1]][[i]]))

# 2. We can use sapply for all the children nodes of the fist course listing `dat_root_XML[[1]]`
sapply(xmlChildren(dat_root_XML[[1]]), xmlName)

# Note that what we are doing is going through each of the nodes of the first child
# and getting their names.

# We can also look at the text in each node
xmlValue(dat_root_XML[[1]])

# So, we can see that we have the some good information on the first course's listing.
# Do we have the same information for the second course listing?
xmlSize(dat_root_XML[[2]])

# Again, we can do this in two ways (at least)
sapply(1:xmlSize(dat_root_XML[[2]]), function(i) xmlName(dat_root_XML[[2]][[i]]))
sapply(xmlChildren(dat_root_XML[[2]]), xmlName)

# Only one section for this class.

# So far we've learned some information on 2,112 (xmlSize(dat_root_XML)) courses from UWM.
# How many sections do we have for each course?
# To find out, let's see if for the first child we can figure out a way to get the number of section listings.
# `xmlElementsByTagName` returns a list of the children or sub-elements of an XML node
# whose tag name matches the one specified by the user.

# If we use it to find `section_listing` in the first child, and we see it's length,
# we should get 2, right? Let's find out.
length(xmlElementsByTagName(dat_root_XML[[1]], 'section_listing'))

# ...for the second child it should be one...
length(xmlElementsByTagName(dat_root_XML[[2]], 'section_listing'))

# Great! This is an oportunity for us to create a function
# to find the number of sections listed for a given course.
get_number_of_sections_listed <- function(node_XML){
        # Getting sections in node
        sections_in_node <- xmlElementsByTagName(node_XML, 'section_listing')

        # Getting number of sections
        number_of_sections <- length(sections_in_node)

        # Returning the number of sections
        return(number_of_sections)
}
# Now, let's use our suite of apply functions with this function to get the number of sections per course.
# Remember, the number of courses is `xmlSize(dat_root_XML)`, and we have all of them in the variable `dat_children_XML`
sections_listed_XML <- sapply(dat_children_XML, get_number_of_sections_listed)

# Let's check...
str(sections_listed_XML)

# Hmm, it would be really good if we could link the number of sections listed the course number.
# We can do something similar to get the course number.
# For the first child (course listed), we can get the elements with tag name 'course'.
xmlElementsByTagName(dat_children_XML[[1]], 'course')

# Look at the structure of the element. It is a XMLInternalElementNode.
xmlElementsByTagName(dat_children_XML[[1]], 'course')

# ...but we want the value of the elements in course.
xmlValue(xmlElementsByTagName(dat_children_XML[[1]], 'course'))

# Let's see if it works for the second course. The course number should be 216-293
xmlValue(xmlElementsByTagName(dat_children_XML[[2]], 'course'))

# Okay, we can now create our function to get the course numbers.
get_course_number <- function(node_XML){
        # Getting course element
        course_element <- xmlElementsByTagName(node_XML, 'course')

        # Getting course number
        course_number <- xmlValue(course_element)

        # Returning course number
        return(course_number)
}

# Now let's use our function with sapply to get the course number of all courses!
course_numbers_XML <- sapply(dat_children_XML, get_course_number)

# Now let's combine course number and course sections in a data.frame
course_df_XML <- data.frame(number = course_numbers_XML, n_sections = sections_listed_XML)
head(course_df_XML)

# Now, which course had the highest number of sections listed?
course_df_XML[which.max(course_df_XML$n_sections),]

# Nice! 18 sections listed! Glad we don't have 18 sections.
# Let's go find that course in our XML data.
# For now, note that by the row number we can see which child it was
dat_children_XML[195] # or dat_root_XML[[195]]

# In the next project, we will cover how we can look for the xml node containing the
# value (course number) we want.

# Note that we can keep looking at the sub-nodes (children) for every node.
# So, suppose we wanted all the start times for all the sections listed
sections_for_american_history <- xmlElementsByTagName(dat_children_XML[[195]], 'section_listing')

# First section
sections_for_american_history[1]

# Make a function
get_section_start_time <- function(node_XML){
        # Getting start time element
        start_time_element <- xmlElementsByTagName(node_XML, 'hours')

        # Getting start time
        start_time <- xmlValue(start_time_element)

        # Returning time
        return(start_time)
}

# Apply our function to all sections listed
start_times <- sapply(sections_for_american_history, get_section_start_time)

# Double check
length(start_times) # should be 18
start_times

# Let's now see how we would solve the examples above using xml2 instead.
# First we need to load all of the necessary packages.
library(xml2)

# Let's parse the data
dat_xml2 <- read_xml('http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/courses/uwm.xml')

# Making sure R knows we are dealing with XML
str(dat_xml2)
class(dat_xml2)

# Getting the root
dat_root_xml2 <- xml_root(dat_xml2)

# Root's name
xml_name(dat_root_xml2)

# Root's size
xml_length(dat_root_xml2)

# What's the name of the root's children?
xml_name(xml_child(dat_root_xml2))

# First child
xml_child(dat_root_xml2)

# All children
dat_children_xml2 <- xml_children(dat_root_xml2)

# We can do the same things for the root's children
xml_length(dat_children_xml2[1])

# Let's look at contents for the first course listing
xml_contents(dat_children_xml2[1])

# Let's explore each of those 8 nodes, and get their names.
# We don't need a sapply here.
xml_name(xml_contents(dat_children_xml2[1]))

# We can also look at the text in each node.
xml_text(dat_children_xml2[1])

# So, we can see that we have the following information on the first course's listing.
# Do we have the same information for the second course listing?
xml_length(dat_children_xml2[2])
xml_name(xml_contents(dat_children_xml2[2]))

# Hmm, just one section for this class.

# How many sections do we have for each course?
# Here we will replace the xmlElementsByTagName from XML to xml_find_all.
# If we use it to find `section_listing` in the first child, and we see it's length,
# we should get 2, right?
length(xml_find_all(dat_children_xml2[[1]], 'section_listing'))

# For the second child it should be one
length(xml_find_all(dat_children_xml2[[2]], 'section_listing'))

# We can create a similar function as before
get_number_of_sections_listed_xml2 <- function(node_XML){
        # Getting sections in node
        sections_in_node <- xml_find_all(node_XML, 'section_listing')

        # Getting number of sections
        number_of_sections <- length(sections_in_node)

        # Returning the number of sections
        return(number_of_sections)
}

# Now let's use it with our apply functions
sections_listed_xml2 <- sapply(dat_children_xml2, get_number_of_sections_listed_xml2)

# Let's check
str(sections_listed_xml2)
all.equal(sections_listed_xml2,sections_listed)

# Ooops, let's remove the names from sections_listed
all.equal(sections_listed_xml2,unname(sections_listed))
# Better.

# Now let's modify our function to get the course numbers
get_course_number_xml2 <- function(node_XML){
        # Getting course element
        course_element <- xml_find_all(node_XML, 'course')

        # Getting course number
        course_number <- xml_text(course_element)

        # Returning course number
        return(course_number)
}

# Now let's use our function with sapply to get the course number of all courses
course_numbers_xml2 <- sapply(dat_children_xml2, get_course_number_xml2)

# Let's check
all.equal(course_numbers_xml2,unname(course_numbers))

# Good. Now let's combine course number and course sections in a data.frame
course_df_xml2 <- data.frame(number = course_numbers_xml2, n_sections = sections_listed_xml2)
head(course_df_xml2)

# Now, which course had the highest number of sections listed?
course_df_xml2[which.max(course_df_xml2$n_sections),]

# Great. We are getting the same results.
# Let's go find that course in our XML data
dat_children_xml2[[195]]

# As mentioned before, in the next project, we will cover how we can look for the xml node
# containing the value (course number) we want.

# Getting the sections listed for `dat_children_xml2[[195]]`
sections_for_american_history <- xml_find_all(dat_children_xml2[[195]],  'section_listing')

# First section
sections_for_american_history[[1]]

# Let's modify our function
get_section_start_time_xml2 <- function(node_XML){
        # Getting start time element
        start_time_element <- xml_find_all(node_XML, 'hours')

        # Getting start time
        start_time <- xml_text(start_time_element)

        # Returning time
        return(start_time)
}

# Applying our function to all sections listed
start_times_xml2 <- sapply(sections_for_american_history, get_section_start_time_xml2)
# Double checking
length(start_times_xml2) # should be 18
start_times_xml2

# Double check
all.equal(start_times_xml2, unname(start_times))

# Okay, bye.
