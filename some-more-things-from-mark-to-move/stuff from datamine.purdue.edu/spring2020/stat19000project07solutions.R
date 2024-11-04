# 1a
library(rvest)

emacs_html <- read_html('https://www.trustradius.com/products/gnu-emacs/reviews')
reviews_emacs <- html_nodes(emacs_html, xpath="//div[@class='review-questions']")
reviews_texts_emacs <- html_text(html_nodes(reviews_emacs, xpath=".//div[@class='not-edited question-text']/div[@class='ugc']"))
print(reviews_emacs[1:2])

scores_emacs <- html_nodes(emacs_html, xpath="//div[@class='trust-score__score']")
scores_texts_emacs <- html_text(html_nodes(scores_emacs, xpath=".//span[not(@class)]"))
print(scores_texts_emacs[1:2])

likely_to_recommend_emacs <- html_nodes(emacs_html, xpath="//div[@class='review-questions']")
likely_to_recommend_emacs_texts <- html_text(html_nodes(likely_to_recommend_emacs, xpath="//div[@class='ugc followup']"))
print(likely_to_recommend_emacs[1:2])

# 1b
# Answer will vary.
# The information from scores vim and emacs would ideally be:
extract_first_score <- function(score_text){ strsplit(score_text," ")[[1]][1] }
count_words <- function(x) {length(strsplit(x, " ")[[1]])}

numeric_scores_vim <- as.numeric(sapply(scores_texts_vim, extract_first_score))
numeric_scores_emacs <- as.numeric(sapply(scores_texts_emacs, extract_first_score))
# assuming the following information from other scores for the purpose of illustration
reviews_vim_word_count <- unname(sapply(reviews_texts_vim, count_words)) # print(reviews_vim_word_count)
reviews_emacs_word_count <- unname(sapply(reviews_text_emacs, count_words))
recommend_vim <- grepl("not recommend|wouldn't recommend|wouldnt recommend",likely_to_recommend_vim )
recommend_emacs <- grepl("not recommend|wouldn't recommend|wouldnt recommend",likely_to_recommend_emacs )

# 1c
# answers will vary.

# 2
# answers will vary.