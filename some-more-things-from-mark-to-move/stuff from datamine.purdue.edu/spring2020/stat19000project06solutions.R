# Please note that in the solutions I am not calling the parsed XML nasa_xml
# as required in question 1.

# Instead I have two versions: nasa_XML and nasa_xml2 to facilitate understanding
# for the two solutions (one using XML package and one using xml2 package).

library(XML)
nasa_XML <- xmlParse('http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/nasa/nasa.xml')

library(xml2)
nasa_xml2 <- read_xml('http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/nasa/nasa.xml')

# 1a
# Using XML package
nasa_root_XML <- xmlRoot(nasa_XML)
datasets_XML <- xmlChildren(nasa_root_XML)
xmlSApply(datasets_XML[[1]], xmlName)

# title        altname        altname        altname
# "title"      "altname"      "altname"      "altname"
# reference       keywords   descriptions      tableHead
# "reference"     "keywords" "descriptions"    "tableHead"
# history     identifier
# "history"   "identifier"

# Using xml2 package
nasa_root_xml2 <- xml_root(nasa_xml2)
datasets_xml2 <- xml_children(nasa_root_xml2)
xml_name(xml_contents(datasets_xml2[[1]]))

# [1] "title"        "altname"      "altname"      "altname"
# [5] "reference"    "keywords"     "descriptions" "tableHead"
# [9] "history"      "identifier"

# 1b
"//identifier"
# or
"/datasets/dataset/identifier"

# Double check using XML package
length(getNodeSet(nasa_XML, "//identifier"))
length(getNodeSet(datasets_XML[[25]], "//identifier"))
length(getNodeSet(nasa_root_XML, "//identifier"))

# 2435

# Double check using xml2 package
length(xml_find_all(nasa_xml2, "//identifier"))
length(xml_find_all(datasets_xml2[[25]], "//identifier"))
length(xml_find_all(nasa_root_xml2, "//identifier"))

# 2435

# 1c
# Using XML package
datasets_identifiers_XML <- xpathSApply(nasa_root_XML, "//identifier", xmlValue)
datasets_identifiers_XML[1:10]

# [1] "I_5.xml"   "I_6.xml"   "I_14.xml"  "I_16.xml"  "I_21A.xml"
# [6] "I_22A.xml" "I_40.xml"  "I_44.xml"  "I_61B.xml" "I_62C.xml"

# or other variations include
datasets_identifiers_XML <- xpathSApply(nasa_XML, "//identifier", xmlValue)
datasets_identifiers_XML[1:10]

# [1] "I_5.xml"   "I_6.xml"   "I_14.xml"  "I_16.xml"  "I_21A.xml"
# [6] "I_22A.xml" "I_40.xml"  "I_44.xml"  "I_61B.xml" "I_62C.xml"

# Using xml2 package
datasets_identifiers_xml2 <- xml_text(xml_find_all(nasa_root_xml2, "//identifier"))
datasets_identifiers_xml2[1:10]

# [1] "I_5.xml"   "I_6.xml"   "I_14.xml"  "I_16.xml"  "I_21A.xml"
# [6] "I_22A.xml" "I_40.xml"  "I_44.xml"  "I_61B.xml" "I_62C.xml"

# or other variations include
datasets_identifiers_xml2 <- xml_text(xml_find_all(nasa_xml2, "//identifier"))
datasets_identifiers_xml2[1:10]

# [1] "I_5.xml"   "I_6.xml"   "I_14.xml"  "I_16.xml"  "I_21A.xml"
# [6] "I_22A.xml" "I_40.xml"  "I_44.xml"  "I_61B.xml" "I_62C.xml"s

# 2a
wsu_XML <- xmlParse('http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/courses/wsu.xml')
wsu_xml2 <- read_xml('http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/courses/wsu.xml')

# Using XML package
enrolled <- xpathSApply(wsu_XML, "//enrolled", xmlValue)
limit <- xpathSApply(wsu_XML, "//limit", xmlValue)

enrolled[1:10] # [1] 108  69  19   4  60  58  60  58  60  58
limit[1:10] # [1] 112  70  40 100  60  60  60  60  60  60

# Using xml2 package
enrolled <- xml_text(xml_find_all(wsu_xml2, "//enrolled"))
limit <- xml_text(xml_find_all(wsu_xml2, "//limit"))

enrolled[1:10] # [1] 108  69  19   4  60  58  60  58  60  58
limit[1:10] # [1] 112  70  40 100  60  60  60  60  60  60

# 2b
enrolled <- as.numeric(enrolled)
limit <- as.numeric(limit)

available_spots <- limit-enrolled
max(available_spots) # [1] 472
mean(available_spots) # [1] 22.94011
quantile(available_spots)[4] # 24

# 2c
plot(limit, type = 'l', main="Enrolled vs Capacity")
lines(enrolled, col = 'red')
