# project 1 examples

# read in data
dat <- read.csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2018/2018-10-16/recent-grads.csv")
head(dat, n=10)

# get a subset of engineers where sample size > 30, only columns up to ShareWomen
eng <- subset(dat, Major_category=="Engineering" & Sample_size > 30, Rank:ShareWomen)

# create new column
eng$ShareMen <- 1 - eng$ShareWomen

# highest percentage of women
eng$Major[which.max(eng$ShareWomen)]

# highest percentage of men
eng$Major[which.max(eng$ShareMen)]

# or
eng$Major[which.min(eng$ShareWomen)]

# pie chart
chem_e <- eng[2,]
pie(c(chem_e$Women, chem_e$Men), labels=c("Women", "Men"))
