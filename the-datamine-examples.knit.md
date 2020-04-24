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

This book contains a collection of examples that students can use to reinforce topics learned in The Data Mine seminar. It is an excellent resource for students to learn what they need to know in order to solve The Data Mine projects.

## How to contribute {#how-to-contribute}

Contributing to this book is simple:

1. Navigate to the page or section that needs to be edited
2. Click on the "Edit" button towards the upper left side of the page:
![](images/edit_button.png)

3. You'll be presented with the respective RMarkdown file. Make your modifications.
4. In the "Commit changes" box, select the radio button that says _Create a **new branch** for this commit and start a pull request._ Give your pull request a title and a detailed description. Name the new branch, and click on "Propose file change".
5. You've successfully submitted a pull request. Our team will review and merge the request shortly thereafter.

<!--chapter:end:index.Rmd-->

# Scholar {#scholar}

## Connecting to Scholar {#connecting-to-scholar}

### ThinLinc web client {#connecting-with-thinlinc-webclient}

1. Open a browser and navigating to https://desktop.scholar.rcac.purdue.edu/.
2. Login with your Purdue Career Account credentials (**without** BoilerKey).
3. Congratulations, you should now be connected to Scholar using the ThinLinc web client.

### ThinLinc client {#connecting-with-thinlinc-client}

1. Navigate to https://webvpn.purdue.edu/. You should see a login screen:
![](images/login.png)
2. Enter your Purdue Career Account credentials (**with** BoilerKey).
3. Download and install the Cisco AnyConnect Secure Mobility Client.
4. Open the AnyConnect client and enter the domain for Purdue's vpn: `webvpn.purdue.edu`, and click "Connect":
![](images/anyconnect.png)
5. When prompted, enter your Purdue Career Account credentials (**with** BoilerKey).
6. You should be successfully connected to Purdue's VPN! You can read more about VPNs [here](#vpns).
7. Navigate to https://www.cendio.com/thinlinc/download, and download the ThinLinc client application for your operating system. 
8. Install and launch the ThinLinc client:
![](images/thinlincclient.png)
9. Enter your Purdue Career Account information (**without** BoilerKey), as well as the server: `desktop.scholar.rcac.purdue.edu`.
10. Click on "Options..." and fill out the "Screen" tab as shown below:
![](images/thinlincoptions.png)
11. Click "OK" and then "Connect". **Make sure you are connected to Purdue's VPN using AnyConnect before clicking "Connect"!**
12. If you are presented with a choice like below, click "Continue".
![](images/thinlincquestion.png)
13. Congratulations, you are now successfully connected to Scholar using the ThinLinc client.
**NOTE: If you do accidentally get stuck in full screen mode, the F8 key will help you to escape.**
**NOTE: The very first time that you log onto Scholar, you will have an option of “use default config” or “one empty panel”. PLEASE choose the “use default config”.**

### SSH {#connecting-with-ssh}

#### Windows {#connecting-to-scholar-ssh-windows}

#### MacOS {#connecting-to-scholar-ssh-macos}

#### Linux {#connecting-to-scholar-ssh-linux}

### JupyterHub {#jupyterhub}

1. Open a browser and navigate to https://notebook.scholar.rcac.purdue.edu/.
2. Enter your Purdue Career Account credentials (**without** BoilerKey).
3. Congratulations, you should now be able to create and run Jupyter notebooks on Scholar!

### RStudio Server {#rstudio-server}

1. Open a browser and navigate to https://rstudio.scholar.rcac.purdue.edu/.
2. Enter your Purdue Career Account credentials (**without** BoilerKey).
3. Congratulations, you should now be able to create and run R scripts on Scholar!

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

## data.table {#r-datatable}

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

## `tensorflow`

## `pytorch`

<!--chapter:end:05-python.Rmd-->

# Tools {#tools}

## Docker {#docker}

## Tableau {#tableau}

## GitHub {#github}

## VPNs {#vpns}

<!--chapter:end:06-tools.Rmd-->

# FAQs {#faqs}

## How do I connect to Scholar from off-campus?

There are a variety of ways to connect to Scholar from off-campus. You can [use the ThinLinc web client](#connecting-with-thinlinc-webclient), or [setup a VPN connection to Purdue's VPN, and connect using the ThinLinc client application](#connecting-with-thinlinc-client). If you just want to use Jupyter notebooks, you can [use JupyterHub](#jupyterhub). If you just want to use RStudio, you can [use RStudio Server](#rstudio-server).

## Is there an advantage to using the ThinLinc client rather than the ThinLinc web client?

Yes. Although it is marginally more difficult to connect with, the ThinLinc client allows the user to copy and paste directly from their native operating system. So for example, if you have an RStudio session opened on your MacBook, you can directly copy and paste code onto Scholar using the ThinLinc client. You are unable to do this via the ThinLinc web client.
  
## GitHub Classroom is not working -- can't authorize the account.

This is usually a browser issue. GitHub Classroom does not work well with Microsoft Edge or Internet Explorer. Try [Firefox](https://www.mozilla.org/en-US/firefox/new/) or Safari or [Chrome](https://www.google.com/chrome/).

## In Scholar, my font size looks weird or my cursor is offset.

In scholar, navigate to `Tools > Global Options > Appearance`, and select the "Monospace" font, and click the "Apply" button.

## How do I make the ThinLinc window bigger without going to the dreaded "full screen" mode?

See [here](https://home.cc.umanitoba.ca/~psgendb/local/public_html/remote/desktop/thinlinc/thinlinc.local.html).

## I'm unable to type into the terminal in RStudio.

Try opening a new terminal, try clearing the terminal buffer, or interrupting the current terminal. All these options come from a menu that will pop up when you hit the small down arrow next to the words "Terminal 1" (it might be another number depending on how many terminals are open) which is on the left side right above the terminal in RStudio. 

## I'm unable to connect to RStudio Server.

Try closing it, clearing your cookies, and using the original link:  https://rstudio.scholar.racac.purdue.edu/, or for ease of scrolling, try https://desktop.scholar.rcac.purdue.edu, and open up RStudio from within the ThinLinc web client.

##

<!--chapter:end:07-faqs.Rmd-->

# Contributors {#contributors}

We are extremely thankful for all of our contributors! Get your name added to the list by [making a contribution](#how-to-contribute).


<!--chapter:end:08-contributors.Rmd-->

