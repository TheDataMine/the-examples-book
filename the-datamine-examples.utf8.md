--- 
title: "The Examples Book"
site: "bookdown::bookdown_site"
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
# url: 'https\://datamine.purdue.edu/examples/'
# cover-image: "images/cover.png"
github-repo: kevinamstutz/the-examples-book
apple-touch-icon: "images/touch-icon.png"
favicon: "images/favicon.ico"
description: "A book of supplemental examples for The Data Mine at Purdue University."
output:
  bookdown::pdf_book:
    number_sections: no
  bookdown::epub_book:
    number_sections: no
  bookdown::gitbook:
    number_sections: no
knit: (function(inputFile, encoding) {
  bookdown::render_book(inputFile, encoding = encoding,
  output_dir = "docs", output_format = "all") })
---

# Introduction {#introduction}

## How to contribute {#how-to-contribute}



<!--chapter:end:index.Rmd-->

# Scholar {#scholar}

## Connecting to Scholar {#connecting-to-scholar}

### ThinLinc {#connecting-with-thinlinc}

### SSH {#connecting-with-ssh}

#### Windows {#connecting-to-scholar-ssh-windows}

#### MacOS {#connecting-to-scholar-ssh-macos}

#### Linux {#connecting-to-scholar-ssh-linux}

### JupyterHub {#jupyterhub}

### RStudio Server {#rstudio-server}

## Resources {#scholar-resources}

<!--chapter:end:01-scholar.Rmd-->

# Unix {#unix}

## Getting started {#unix-getting-started}

## Standard utilities {#unix-utilities}

### `man` {#man}

#### `tldr` {#tldr}

### ~ & . & .. {#dots}

### `cat` {#cat}

### `ls` {#ls}

### `cp` {#cp}

### `mv` {#mv}

### `pwd` {#pwd}

### `touch` {#touch}

### `wc` {#wc}

### `ssh` {#ssh}

#### `mosh` {#mosh}

### `scp` {#scp}

### `awk` {#awk}

### `sed` {#sed}

### `grep` {#grep}

#### `ripgrep` {#rg}

### `find` {#find}

#### `fd` {#fd}

### `top` {#top}

### `less` & `more` {#less-and-more}

### `sort` {#sort}

## Piping & Redirection {#piping-and-redirection}

## Emacs {#emacs}

## Nano {#nano}

## Vim {#vim}

## Writing scripts {#writing-scripts}

<!--chapter:end:02-unix.Rmd-->

# SQL {#sql}

### RDBMS

### SQL in R

### SQL in Python

<!--chapter:end:03-sql.Rmd-->

# R {#r}

## Getting started {#getting-started-with-r}

How to install R (windows/mac/linux)
How to install RStudio
How to connect to RStudio Server on Scholar
How to get help (?, help(), get function itself)

## Variables {#r-variables}

## Logical operators {#r-logical-operators}

## Lists & Vectors {#r-lists-and-vectors}

## Basic R functions {#r-basic-functions}

## Data.frames {#r-data-frames}

## Reading & Writing data {#r-reading-and-writing-data}

## Control flow {#r-control-flow}

## Apply functions {#r-apply-functions}

### `apply` {#r-apply}

### `sapply` {#r-sapply}

### `lapply` {#r-lapply}

### `tapply` {#r-tapply}

## Writing functions {#r-writing-functions}

## Plotting {#r-plotting}

### `ggplot2` {#r-ggplot2}

## RMarkdown {#r-rmarkdown}

## Tidyverse {#r-tidyverse}

## Data.table's {#r-datatables}

## SQL in R {#r-sql}

## Scraping {#r-scraping}

## `shiny` {#r-shiny}



<!--chapter:end:04-r.Rmd-->

# Python {#python}

## Getting started {#getting-started-with-python}

## Lists & Tuples {#p-lists-and-tuples}

## Dicts {#p-dicts}

## Control flow {#p-control-flow}

## Writing functions {#p-writing-functions}

## Reading & Writing data {#p-reading-and-writing-data}

## `numpy` {#p-numpy}

## `scipy` {#p-scipy}

## `pandas` {#p-pandas}

## Jupyter notebooks {#p-jupyter-notebooks}

## Writing scripts {#p-writing-scripts}

### `argparse` {#p-argparse}

## Scraping {#p-scraping}

## Plotting {#p-plotting}

### `matplotlib` {#p-matplotlib}

### `plotly` {#p-plotly}

### `plotnine` {#p-plotnine}

### `pygal` {#p-pygal}

### `seaborn` {#p-seaborn}

### `bokeh` {#p-bokeh}

## Classes {#p-classes}

<!--chapter:end:05-python.Rmd-->

# Tools {#tools}

## Docker {#docker}

## Tableau {#tableau}

## GitHub {#github}

## VPNs {#vpns}

<!--chapter:end:06-tools.Rmd-->

# FAQs {#faqs}

<!--chapter:end:07-faqs.Rmd-->

# Contributors {#contributors}

We are extremely thankful for all of our contributors! Get your name added to the list by [making a contribution](#how-to-contribute).


<!--chapter:end:08-contributors.Rmd-->

