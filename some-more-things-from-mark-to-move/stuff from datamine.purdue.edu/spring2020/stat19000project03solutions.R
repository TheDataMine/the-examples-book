# 1a
load("~/path/to/stopwords.RData")
dat <- read.csv("https://raw.githubusercontent.com/zygmuntz/goodbooks-10k/master/books.csv")
count_stop_words <- function(x) {sum(strsplit(tolower(x), " ")[[1]] %in% stopwords)}

# 1b
stop_words_per_title <- sapply(tolower(dat$original_title), count_stop_words)
which.max(stop_words_per_title) # 3835
max(stop_words_per_title) # 16

# 1c
hist(stop_words_per_title)

# 2a
cast_length <- unname(sapply(sapply(movies$cast, strsplit, ','), length))
max(cast_length) # 306
movies[which.max(cast_length),'movie_title']  # "Malcolm X"

# 2b
split_frames <- split(reviews, reviews$critic_top)
names(split_frames) <- c("not_top", "top")

#           Top Critic
# 19.63788   20.79486

# 3a
movies_id <- reviews$rotten_tomatoes_link[grepl('soul', reviews$review_content)]
tapply(movies$tomatometer_rating, movies$rotten_tomatoes_link %in% movies_id, mean)
