reviews <- read.csv('rotten_tomatoes_reviews.csv', stringsAsFactors = FALSE)
movies <- read.csv('rotten_tomatoes_movies.csv', stringsAsFactors = FALSE)

# 1a
categorize_score <- function(score){
        score_category <- ifelse(score>=60, 'Fresh', 'Rotten')
        return(score_category)
}

categorize_score(movies$tomatometer_rating[movies$movie_title == 'Shadow Company'])

# "Fresh"

# 1b
summarize_scores <- function(score1, score2){
        mean_score <- mean(c(score1, score2), na.rm=TRUE)
        return(mean_score)
}

summarize_scores(movies$tomatometer_rating[movies$movie_title == 'Flashback'],
                 movies$audience_rating[movies$movie_title == 'Flashback'])

# 49.5

# 1c
choose_scores <- function(score_vector, categorize = TRUE){
        mean_score <- summarize_scores(score_vector[1], score_vector[2])
        if(categorize) {
                mean_score <- categorize_score(mean_score)
        }
        return(mean_score)
}

score_vec <- as.numeric(movies[movies$movie_title == 'Flashback', c('tomatometer_rating', 'audience_rating')])
choose_scores(score_vec)

# "Rotten"

choose_scores(score_vec, categorize = FALSE)

# 49.5

# alternative
flashback <- movies[movies$movie_title == 'Flashback', ]
choose_scores(c(flashback$tomatometer_rating, flashback$audience_rating))

# 1d
table(apply(movies[, c('tomatometer_rating', 'audience_rating')], 1, choose_scores))
# Fresh Rotten
# 9049   7589

# 1e
movies$our_scores <- apply(movies[, c('tomatometer_rating', 'audience_rating')], 1, choose_scores)
subset_combined_dat <- merge(reviews[,c('rotten_tomatoes_link', 'critic_icon')],
                             movies[,c('rotten_tomatoes_link', 'our_scores')],
                             by='rotten_tomatoes_link')


tb = table(critic = subset_combined_dat$critic_icon, our = subset_combined_dat$our_scores)
tb

# % of `Fresh` reviews did our score classified as `Rotten`?
100*tb[1,2]/sum(tb[1,])

# 23.2883

# What percentage of reviews did we classify in the same category as the critics in `reviews` data?
prop.table(tb)
or
(tb[1,1]+tb[2,2])/sum(tb)

# .7546582

# 2
# the problem is that within the my_score_conversion function, we need to specify the type in the weight_score functions.
# currently, the fuction is reading from the environment, introducing unexpected behavior.

# testing idea out
tomatometer_rating <- c(10, 90, 65)
audience_rating <- c(86, 55, 45)

        # example of doing a weighted mean score
        (tomatometer_rating*0.8+audience_rating*1.2)/2

        # function to weight scores
        weight_score <- function(score, type){
                if(type == 'critic') score <- score*0.8
                if(type == 'audience') score <- score*1.2
                return(score)
        }

# for critics we will down-weight
type <- "critic"
weight_score(tomatometer_rating, type)

# for audience we will up-weight
type <- "audience"
weight_score(audience_rating, type)

my_score_conversion <- function(tomatometer_rating, audience_rating){
        # down-weight
        tomatometer_rating <- weight_score(tomatometer_rating, type="critic")

        # up-weight
        audience_rating <- weight_score(audience_rating, type="audience")

        return(rowMeans(cbind(tomatometer_rating, audience_rating), na.rm=TRUE))
}

new_scores <- my_score_conversion(movies$tomatometer_rating, movies$audience_rating)

# score for movie in row 123
new_scores[123] # should be 54.4
