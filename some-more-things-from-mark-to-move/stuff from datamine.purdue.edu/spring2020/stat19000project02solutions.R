# STAT 19000 Project 2 Solutions

# 1a
dat <- read.csv('https://raw.githubusercontent.com/zygmuntz/goodbooks-10k/master/books.csv', stringsAsFactors = FALSE)
dim(dat) # 10000    23

# 1b
count <- function(x) {length(strsplit(x, " ")[[1]])}
original_title_length <- sapply(dat$original_title, count)

max(original_title_length) # 33
which.max(original_title_length) # 3835

# 1c
ratings <- subset(dat, select=c("average_rating", "ratings_count", "work_ratings_count", "ratings_1", "ratings_2", "ratings_3", "ratings_4", "ratings_5"))
sapply(ratings, min)
# average_rating      ratings_count work_ratings_count
# 2.47            2716.00            5510.00
# ratings_1          ratings_2          ratings_3
# 11.00              30.00             323.00
# ratings_4          ratings_5
# 750.00             754.00

# 2a
dat_subset <- subset(dat, select = grep('count|rating', names(dat)))

# 2b
sapply(dat_subset, summary, simplify = F)
# $books_count
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 1.00   23.00   40.00   75.71   67.00 3455.00
#
# $average_rating
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 2.470   3.850   4.020   4.002   4.180   4.820
#
# $ratings_count
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 2716   13569   21156   54001   41054 4780653
#
# $work_ratings_count
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 5510   15439   23832   59687   45915 4942365
#
# $work_text_reviews_count
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 3     694    1402    2920    2744  155254
#
# $ratings_1
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 11     196     391    1345     885  456191
#
# $ratings_2
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 30     656    1163    3111    2353  436802
#
# $ratings_3
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 323    3112    4894   11476    9287  793319
#
# $ratings_4
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 750    5406    8270   19966   16024 1481305
#
# $ratings_5
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# 754    5334    8836   23790   17304 3011543

# 3a
reviews <- read.csv('rotten_tomatoes_reviews.csv', stringsAsFactors = FALSE)
movies <- read.csv('rotten_tomatoes_movies.csv', stringsAsFactors = FALSE)

length(unique(reviews$rotten_tomatoes_link))
dim(reviews)
# reviews : 16594

length(unique(movies$rotten_tomatoes_link))
dim(movies)
# movies : 16638

# 3b
sum(unique(reviews$rotten_tomatoes_link) %in% unique(movies$rotten_tomatoes_link))
# in common: 16594

# 3c
tapply(reviews$critic_score, as.factor(reviews$rotten_tomatoes_link), mean, na.rm=TRUE)

# first 5
tapply(reviews$critic_score, as.factor(reviews$rotten_tomatoes_link), mean, na.rm=TRUE)[1:5]

# 3d
RotOrFresh <- tapply(reviews$critic_icon, reviews$rotten_tomatoes_link, table)
sapply(RotOrFresh, max) - sapply(RotOrFresh, min)

# /m/0814255 /m/0878835  /m/1_2013 /m/1_night      /m/10
# 7        NaN        NaN        NaN        NaN

# first 5
(sapply(RotOrFresh, max) - sapply(RotOrFresh, min))[1:5]

# /m/0814255 /m/0878835  /m/1_2013 /m/1_night      /m/10
# 3        102          7          2          8