# 1a
# What is XML and what does it stand for?

# Answers for the first part may vary. Possible examples include:
# XML is a file format which shares both the file format and the data anywhere using standard ASCII text (such as the World Wide Web)
# XML is a format used to structure data so that it can be stored and transported.
# XML is designed to send, store, receive and display data.
# XML is a markup language which encodes documents by defining a set of rules in both machine-readable and human-readable format.

# XML stands for Extensible Markup Language.

# 1b
# Answers may vary. Examples include:
# https://techdifferences.com/difference-between-xml-and-html.html

# 2a
# Using XML package
library(XML)
dat <- xmlParse('http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/nasa/nasa.xml')
dat_root <- xmlRoot(dat)
xmlName(dat_root) # datasets
xmlSize(dat_root) # 2435

# Using xml2 package
library(xml2)
dat_xml2 <- read_xml('http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/nasa/nasa.xml')
dat_root_xml2 <- xml_root(dat_xml2)
xml_name(dat_root_xml2) # datasets
xml_length(dat_root_xml2) # 2435

# 2b
# The XML is providing us with actual datasets, and information about those datasets.

# Using XML package
sapply(dat_root[1:10], xmlSize) # No, it varies between 10, 11, 12 and 13

# or
dat_children <- xmlChildren(dat_root)
sapply(dat_children[1:10], xmlSize)

# Using xml2 package
dat_childrens_xml2 <- xml_children(dat_root_xml2)
sapply(dat_childrens_xml2[1:10], xml_length)

# No, it varies between 10, 11, 12 and 13

# 3a

# Function to count words in a vector (from project 2, question 1b solutions)
count <- function(x) {length(strsplit(x, " ")[[1]])}

# Using XML
get_title_length <- function(node_XML){
        # Getting title element
        title_element <- xmlElementsByTagName(node_XML, 'title')

        # Getting title
        title <- xmlValue(title_element)

        # Getting word count
        title_length <- count(title)

        # Returning time
        return(title_length)
}

# Children (nodes)
xml_Children <- xmlChildren(dat_root)

# Getting title lengths
title_lengths <- sapply(xml_Children, get_title_length)

# Printing it
xmlValue(xmlElementsByTagName(xml_Children[[which.max(title_lengths)]], 'title'))

# Using xml2
get_title_length_xml2 <- function(node_XML){
        # Getting title element
        title_element <- xml_find_all(node_XML, 'title')

        # Getting title
        title <- xml_text(title_element)

        # Getting word count
        title_length <- count(title)

        # Returning time
        return(title_length)
}

# Getting title lengths
title_lengths_xml2 <- sapply(dat_childrens_xml2, get_title_length_xml2)

# Printing it
xml_text(xml_find_all(dat_childrens_xml2[[which.max(title_lengths_xml2)]], 'title'))

# 3b
# answers will vary

