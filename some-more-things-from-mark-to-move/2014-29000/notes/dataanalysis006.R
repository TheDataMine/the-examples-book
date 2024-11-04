# We can open R through the menu (at the upper-level corner of the screen)
# on llc by Applications -> System Tools -> Terminal
# When the terminal opens, we can type R (and then hit return).

# We open Firefox and go to http://www.r-project.org to get to CRAN.
# Within the webpage, we click on CRAN on the left-hand side of the page.

# Then we choose a CRAN Mirror, e.g., http://ftp.ussg.iu.edu/CRAN
# Then choose Packages on the left-hand side of the screen.

# 5788 packages are available for R in August 2014.
# Click on "Table of available packages, sorted by name".

# Many packages are available.  We scroll down to "maps" as an example.
# We get the documentation for maps.
# Then we can click on the Reference manual: maps.pdf (middle of the page)
# The pdf probably opens directly inside your Firefox web browser.
# You can see many of the functions inside the maps package.

# There is a basic function called "map" on page 8 of the pdf file.
# At the bottom of page 10 and the top of page 11, we have example code.
# We can run this sample code in R very easily.
# We go back over to the R environment (which we opened earlier).

# We can type in R:

install.packages("maps")

# The very first time you install a package, R will give an error:
# Warning in install.packages("maps") :
#  'lib = "/opt/R-3.0.2/lib64/R/library"' is not writable
# Would you like to use a personal library instead?  (y/n)
# You should type  y  and then return
# Then it will ask:
# Would you like to create a personal library
#  ~/R/x86_64-unknown-linux-gnu-library/3.0
#  to install packages into?  (y/n)
# You should type  y  and then return

# R will ask which mirror you want to use.
# You can use USA (IN) for instance.
# Then the installation will proceed automatically.
# It should say at the end:
# The downloaded source packages are in
#   '/tmp/RtmpeWkPX1/downloaded_packages'
# or something similar (the RtmpeWkPX1 might be different for you)

# Now the maps packages has been installed but not loaded.
# You only have to install a package once,
# but you have to load a package every time you want to use it,
# at the start of the R session.

library("maps")

# To see the example code from the map function, we can type:

example(map)

# A secondary plotting window comes up.
# We need to **repeatedly** hit "return" in the R window, 
# to make the maps appear in the secondary plotting window.
# Each time we hit return, a new map appears.

# Once the example is over, you get the regular R prompt back.

# Then we quit:

q()

# and type  n  to signify that we do not need to save the workspace image.

# Then we can type   exit in the terminal to close the terminal.
# We can close Firefox.
# Finally, we can log out of llc by choosing
#   System -> Log out    at the top of the screen.



