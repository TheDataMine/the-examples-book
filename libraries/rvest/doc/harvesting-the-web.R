## ---- echo=FALSE--------------------------------------------------------------
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

## ---- echo=FALSE--------------------------------------------------------------
embed_png("harvesting-web-1-s.png")

## ---- echo=FALSE--------------------------------------------------------------
embed_png("harvesting-web-2-s.png")

## ---- echo=FALSE--------------------------------------------------------------
embed_png("harvesting-web-3-s.png")

## ---- echo=FALSE--------------------------------------------------------------
embed_png("harvesting-web-4-s.png")

## ---- echo=FALSE--------------------------------------------------------------
embed_png("harvesting-web-5-s.png")

## ---- echo=FALSE--------------------------------------------------------------
embed_png("harvesting-web-6-s.png")

## ---- echo=FALSE--------------------------------------------------------------
embed_png("harvesting-web-7-s.png")

## -----------------------------------------------------------------------------
library(rvest)
lego_url <- "http://www.imdb.com/title/tt1490017/"
html <- read_html(lego_url)

characters <- html_nodes(html, ".cast_list .character")

length(characters)

characters[1:2]
html_text(characters, trim=TRUE)

## -----------------------------------------------------------------------------
html_nodes(html,".cast_list") %>% 
  html_name()

## -----------------------------------------------------------------------------
html_node(html,".cast_list")

## -----------------------------------------------------------------------------
html_node(html,".cast_list") %>% 
  html_table() %>% 
  head()

## -----------------------------------------------------------------------------
html_node(html, ".cast_list .character") %>% 
  html_text()

## -----------------------------------------------------------------------------
html_nodes(html, ".cast_list .character") %>% 
  html_children() %>% 
  html_attr("href")

## ---- echo=FALSE--------------------------------------------------------------
embed_png("harvesting-web-8-s.png")

## -----------------------------------------------------------------------------
html_node(html, ".cast_list .character") %>% 
  html_children() %>% 
  html_text()

## -----------------------------------------------------------------------------
html_node(html, ".cast_list .character") %>% 
  html_nodes(xpath="./text()[normalize-space()]")

## -----------------------------------------------------------------------------
html_node(html, ".cast_list .character") %>% 
  html_nodes(xpath="./text()[normalize-space()]") %>% 
  html_text(trim=TRUE)

