## ---- echo = FALSE------------------------------------------------------------
embed_png <- function(path, dpi = NULL) {
  meta <- attr(png::readPNG(path, native = TRUE, info = TRUE), "info")
  if (!is.null(dpi)) meta$dpi <- rep(dpi, 2)

  knitr::asis_output(paste0(
    "<img src='", path, "'",
    " width=", round(meta$dim[1] / (meta$dpi[1] / 96)),
    " height=", round(meta$dim[2] / (meta$dpi[2] / 96)),
    " />"
  ))
}

knitr::opts_chunk$set(comment = "#>", collapse = TRUE)


## ----results="asis", echo=FALSE-----------------------------------------------
# directly adding css to output html without ruining css style https://stackoverflow.com/questions/29291633/adding-custom-css-tags-to-an-rmarkdown-html-document
cat("
<style>
img {
border: 0px;
outline: 0 ;
}
</style>
")

## ---- echo = FALSE------------------------------------------------------------
embed_png("selectorgadget-1-s.png")

## ---- echo = FALSE------------------------------------------------------------
embed_png("selectorgadget-2-s.png")

## ---- echo = FALSE------------------------------------------------------------
embed_png("selectorgadget-3-s.png")

## ---- echo = FALSE------------------------------------------------------------
embed_png("selectorgadget-4-s.png")
embed_png("selectorgadget-5-s.png")

## -----------------------------------------------------------------------------
library(rvest)
lego_url <- "http://www.imdb.com/title/tt1490017/"
html <- read_html(lego_url)
cast <- html_nodes(html, ".primary_photo+ td a")
length(cast)
cast[1:2]

## -----------------------------------------------------------------------------
html_text(cast, trim = TRUE)

## -----------------------------------------------------------------------------
cast_attrs <- html_attrs(cast)
length(cast_attrs)
cast_attrs[1:2]

## -----------------------------------------------------------------------------
cast_rel_urls <- html_attr(cast, "href")
length(cast_rel_urls)
cast_rel_urls[1:2]

cast_abs_urls <- html_attr(cast, "href") %>% 
  url_absolute(lego_url)
cast_abs_urls[1:2]

