# Main packages we will be using here are:
# rvest, xml2
# rvest requires xml2, however you don't need to load it.

# Find some useful resources/documentation on rvest below:
# https://stat4701.github.io/edav/2015/04/02/rvest_tutorial/
# https://github.com/tidyverse/rvest
# https://blog.rstudio.com/2014/11/24/rvest-easy-web-scraping-with-r/

# We will show you have to scrape and analyze some webpages using rvest + XML or rvest + xml2

# First, we need to load the required package
library(rvest)

# In the following examples we are going to walk you through the process of scraping
# data from the web. What this means is, given a website, we will programmatically
# extract information. This can be very useful if you need to build a dataset,
# itemize difficult-to-copy-and-paste portions of a website, etc.

# Let's get the data!
# The first step in the process is to use a package to download HTML of a webpage
# you want to scrape. Puppies are good, so let's scrape some information from
# reddit.

# The url of the website we want to scrape
puppies_url <- 'https://old.reddit.com/r/puppies/top/?sort=top&t=all'

# Let's download the html now using the read_html function from xml2
puppies_html <- read_html(puppies_url)

# Let's take a look at the structure
str(puppies_html) # This should look familiar

# Great, the next step to scrape data is to figure out what
# we want to scrape. How about we scrape the rank (1-25),
# upvotes, and title for the top 25 posts (all of the posts on our webpage)

# So, we have the 3 pieces of info we want to scrape. The next step is to
# open up a modern web browser -- we will use Firefox for these examples,
# but Chrome should look nearly identical.

# Navigate to https://old.reddit.com/r/puppies/top/?sort=top&t=all
# and right click on the number 1 (to the left of the first post)
# and select "Inspect Element". This should open up an inspector in the browser.

# You can see that the information we want is the value inside the <span> tag
# that has an attribute "class" with value "rank". If you hover your mouse over the
# lines in the Inspector console, you will see that they highlight the objects
# you are hovering over inside the webpage! Cool!

# If you hover over the lines above your newly found <span> tag, you will see that the
# first post (including image, title, all the info, etc) is all inside the <div>
# tag with a LOT of attributes (some include: id, class, onclick, data-fullname, data-score, data-rank, etc).
# Attributes can be useful in identifying the type of data you are trying to scrape.
# For example the "data-rank" attribute has the rank information we are looking for,
# so we don't really even need that <span> tag. I would almost guess that
# any tag containing the "data-rank" attribute will be a <div> tag containing a post!
# Sometimes just looking for patterns of organization in the webpage will help us
# figure out ways to parse out the information we want from the HTML. Let's see if
# we are correct in saying all tags with a "data-rank" attribute are <div>'s
# containing posts.
post_divs <- html_nodes(puppies_html, xpath="//div[@data-rank]")

# We found 25, exactly what we are expecting! Now
# we can extract all the information we are looking for
# for each node.
length(post_divs)

# Let's take the first post only and see how to get the rank, title, and upvotes.
first_post <- post_divs[[1]]

# Let's start with rank. Easy.
rank <- html_text(html_node(first_post, xpath=".//@data-rank"))

# Okay, let's take a look in the Inspector and see where the title is hiding.
# As I hover over nodes inside the div, I see that a <div class="entry unvoted"></div>
# appears to contain the title and other information below the title. Let's see
# where the title is inside that <div>. It looks like it is inside another <div>,
# specifically, <div class="top-matter"></div>. Now we are getting close!
# I can see a <p class="title"></p> this must be where the title lives. Sure
# enough, inside the <p class="title></p> there is another node: <a class="title ...">OUR TITLE IS HERE</a>.

# Let's review. We have our <div> node containing all of our information in our variable "first_post".
# Inside first_post, we have a <div class="entry unvoted"></div>, then <div class="top-matter"></div>,
# then <p class="title"></p>, then <a class="title ...">OUR TITLE IS HERE</a>.
# How do we get that title?
html_text(html_node(first_post, xpath=".//a[contains(@class, 'title')]"))

# There are a couple of things to explain here:
# First post is our div containing all of our info for the first post.
# .//a[contains(@class, 'title')] means from the context of our first post (.//),
# find an "a" node (a) that has an attribute called class that contains
# a value 'title' (contains(@class, 'title')). Note that class contains
# many different values in addition to 'title', and the contains function
# allows us to just see if the value we are looking for is within the attribute.

# Let's get the upvotes. As usual, let's go back to the Inspector and see.
# It looks like, within our first post div, there is another: <div class="midcol unvoted"></div>
# Inside that, you can see a <div class="score unvoted" title="13289">13.3k</div>.
# Interesting! It looks like the raw value is in the title attribute. Let's get it.
html_attr(html_node(first_post, xpath=".//div[@class='score unvoted' and @title]"), "title")

# Note that this time we used the html_attr function to extract the value of the attribute "title".

# Cool. Now let's see if we can get all 25 at once.
html_text(html_nodes(post_divs, xpath=".//@data-rank"))
html_text(html_nodes(post_divs, xpath=".//a[contains(@class, 'title')]"))
html_attr(html_nodes(post_divs, xpath=".//div[@class='score unvoted' and @title]"), "title")

# Not so bad!

# To help with our analysis, let's store all the information in specific vectors
posts_rank <- html_text(html_nodes(post_divs, xpath=".//@data-rank"))
posts_title <- html_text(html_nodes(post_divs, xpath=".//a[contains(@class, 'title')]"))

# In the same way 'contains' enables you to make sure an attribute has a value, there is another
# function called 'not' that makes sure the tag doesn't have a certain attribute.
posts_number_of_upvotes <- html_attr(html_nodes(post_divs, xpath=".//div[@class='score unvoted' and @title]"), "title")

# Now, notice that the number of upvotes is being consider a character, but it is actually a number.
str(posts_number_of_upvotes)

# The same thing is happening with rank.
str(posts_rank)

# Okay, let's fix this!
posts_number_of_upvotes <- as.numeric(posts_number_of_upvotes)
posts_rank <- as.numeric(posts_rank)

# Ahh, much better!
# Having the data all together in a data.frame provides a better framework to do analysis.
# This ensures we have everything tied together. So, let's combine the rank, number of upvotes and the title
# from each post into a data.frame called puppies_df, df for data.frame.
# Let's make sure our titles get stored as character, and not as factors by adding the argument
# stringAsFactors = FALSE
puppies_df <- data.frame(rank = posts_rank,
                         title = posts_title,
                         n_upvotes = posts_number_of_upvotes,
                         stringsAsFactors = FALSE)


# Double checking is always important
str(puppies_df)
head(puppies_df)

# Good, everything looks right!
# Hm, I wonder if how long the title is has any relationship with how many upvotes the post gets.
# Let's see if, for this data, we can find that out. Remember that in previous projects we had a function
# to calculate the number of words in a sentence? We will use it below to get the number of words in the post's title.

# In addition, to keep things tidy, let's make sure this information is stored in our data.frame.
# First things first, we need to read in the count_words() function
count_words <- function(x) {length(strsplit(x, " ")[[1]])}

# This function works for one sentence, and it is not vectorized. Here is how we can double check that:
count_words(puppies_df$title[1])
puppies_df$title[1]

# Ok our function is working. Will it work for a vector of sentences though?
count_words(puppies_df$title[1:2])

# Not really. So we need to use the sapply function to help us out! Now, let's actually count the words!
puppies_df$n_words_title <- sapply(puppies_df$title, count_words)

# We can explore this relationship in many ways..
# We can do scatterplots
plot(puppies_df$n_words_title, puppies_df$n_upvotes)

# Kind of hard to see a pattern in this scatterplot. What if we remove our two outliers?
# Let's first find them!
which.max(puppies_df$n_words_title)
which.max(puppies_df$n_upvotes)

# Removing the 2 outliers..
puppies_df_no_outliers <- puppies_df[-c(1:2),]

# Looking at the scatterplot again
plot(puppies_df_no_outliers$n_words_title, puppies_df_no_outliers$n_upvotes)

# Doesn't seem to be an apparent relationship between number of words in a title and number of upvotes.
# Let's try to quantify what we are seeing in the scatterplot.
# How about if we look at the relationship using the correlation function cor()?
# Correlation values are between -1 and 1. Values closer to 1 means positively correlated, that is,
# as number of words in titles increase so does the number of upvotes). Values closer to -1 means negatively correlated, that is, as number of titles increase, the number of upvotes decreases.
# Values of 0 mean no correlation. What would do you expect this number will be? Let's see..
cor(puppies_df$n_words_title, puppies_df$n_upvotes)

# Some people may say that posts with a medium number of words actually get more upvotes.
# Their logic is that medium lengths provides information, but not overwhelmingly so.
# How about we take a look. To do so, we will create a function that, depending on the word count,
# will classify a title into: small, medium and large. Here we will do the following cut off
# number of words < 6 -> small title
# 6 <= number of words < 12 -> medium title
# number of words >= 12 -> large title
classify_title <- function(title_length){
        if(title_length < 6){
                class <- 'small'
        } else if(title_length < 12){
                class <- 'medium'
        } else{
                class <- 'large'
        }
        return(class)
}

# Let's test our function to make sure it works, right?
# classify_title(4) should return 'small'
# classify_title(6) should return 'medium'
# classify_title(12) should return 'large'
classify_title(4)
classify_title(6)
classify_title(12)

# Great! Let's use our new classify_title() function and sapply (to vectorize it)
# to get our title classification. Again, we are keeping everything in our data.frame to
# keep our data tidy.
puppies_df$title_class <- sapply(puppies_df$n_words_title, classify_title)

# One way to continue exploring the relationship between the length of the title and the number of
# upvotes, is to see how the number of upvotes looks like for each class (small, medium, & large)
# Let's calculate the mean number of upvotes in each class.
# We will use the tapply function to help us do this!
tapply(puppies_df$n_upvotes, puppies_df$title_class, mean)

# Hmm, interesting. But let's make sure we have a somewhat comparable number in each class
table(puppies_df$title_class)

# or if we feel like we want to use tapply, we could do
tapply(puppies_df$n_upvotes, puppies_df$title_class, length)

# Yes, we do. Curious. Let's try looking at the median in case we have some outliers here.
tapply(puppies_df$n_upvotes, puppies_df$title_class, median)

# It looks like the outliers are driving our means.
# Let's create some classes for the number of upvotes as well instead of looking at the
# raw numeric values. Again, we begin by creating a function to classify the number of upvotes.
# Let's assume number of upvotes measures the popularity of the post.
classify_popularity <- function(upvotes_number){
        if(upvotes_number < 1400){
                class <- 'not so popular'
        } else{
                class <- 'very popular'
        }
        return(class)
}

# Again, we are going to use the functions classify_popularity() and sapply(), and we will continue
# to keep everything in our data.frame to keep things tidy
puppies_df$popularity <- sapply(puppies_df$n_upvotes, classify_popularity)

# Checking the distribution
table(puppies_df$popularity)

# Now let's compare the two popularity classes with the 3 title length classes
my_table <- table(puppies_df$popularity, puppies_df$title_class)
my_table

# We can also use graphs, like barplots (the different colors are for each popularity)
barplot(my_table, beside = TRUE, legend = rownames(my_table))

# Of course, these are just examples of how we can explore the relationship between these variables.
# In project 07 you will have a chance to do something similar. Don't feel restricted by what we did here.
# We are just trying to show some different approaches one can take when looking at this data.

# Have fun!