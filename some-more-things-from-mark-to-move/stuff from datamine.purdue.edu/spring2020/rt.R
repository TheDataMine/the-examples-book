library(rvest)
library(httr)
library(jsonlite)

# function that, given a rotten tomatoes id, returns
# a link to the cover image
scrape_cover_link <- function(rt_id) {
    url <- paste("https://www.rottentomatoes.com/m/", rt_id, sep="")
    html <- read_html(url)

    # get the cover
    cover_link <- html_attr(html_node(html, xpath="//div[@class='movie-thumbnail-wrap']//img"), "data-src")
    return(cover_link)
}

scrape_tomatometer_score <- function(rt_id) {
    url <- paste("https://www.rottentomatoes.com/m/", rt_id, sep="")
    html <- read_html(url)

    # get the score
    score <- html_text(html_node(html, xpath="//a[@id='tomato_meter_link']//span[@class='mop-ratings-wrap__percentage']"))
    return(score)
}

scrape_audience_score <- function(rt_id) {
    url <- paste("https://www.rottentomatoes.com/m/", rt_id, sep="")
    html <- read_html(url)

    # get the score
    score <- html_text(html_node(html, xpath="//div[contains(@class, 'audience-score')]//span[@class='mop-ratings-wrap__percentage']"))
    return(score)
}

scrape_title <- function(rt_id) {
    url <- paste("https://www.rottentomatoes.com/m/", rt_id, sep="")
    html <- read_html(url)

    # get the title
    title <- html_text(html_node(html, xpath="//h1[@class='mop-ratings-wrap__title mop-ratings-wrap__title--top']"))
    return(title)

}

scrape_critics_consensus <- function(rt_id) {
    url <- paste("https://www.rottentomatoes.com/m/", rt_id, sep="")
    html <- read_html(url)

    # get the consensus
    consensus <- html_text(html_node(html, xpath="//p[@class='mop-ratings-wrap__text mop-ratings-wrap__text--concensus']"))
    return(consensus)
}