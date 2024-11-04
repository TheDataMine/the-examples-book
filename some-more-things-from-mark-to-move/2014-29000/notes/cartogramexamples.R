myshapedata <- readShapePoly("/proj/www/2014/29000/projects/usamaps/usa_st.shp")

MakeACartogram(myshapedata, 1:51, rep(1,times=51),
   rep("blue",times=51),  1/5,  4)

MakeACartogram(myshapedata, c(1,2,7,16),   c(8,1,1,1),   c("red", "blue","yellow","green"),  2.5,  8)

projection<-CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
tomsshapedata <- readShapePoly("/proj/www/2014/29000/projects/germanymaps/DEU_adm1_plus_projects.shp",proj4string=projection)

#  this will make a chart of all 16 regions of Germany, with value of 1 per region.
#  I emphasize that we draw Berlin and Bremen last of all (e.g., here, in grey and magenta).
#    (If we do not plot Berlin and Bremen at the end, then they are destroyed/overlapped by the color of the larger regions that surround them.)
MakeACartogram(tomsshapedata, c(1,2,4,6,7,8,9,10,11,12,13,14,15,16,3,5),  rep(1,times=16),   c("red", "blue", "yellow", "green", "orange", "purple", "brown", "black", rep("white", times=6), "grey", "magenta"),  1/5,  20)

# This is something like what you wanted to do.  I made two changes, however.
# I scaled by the max of the projsPercent instead of by the sum of projsPercent
#   This scaling will not affect the cartogram shape at all, because all values are scaled the same amount.
#   However, I also chose the hsv colors according to the "s" factor instead of the "h" factor,
#      so that the more intense colors come with the high numbers of the goodprojvalues.
projsscaledbymax <- tomsshapedata@data$projects/max(tomsshapedata@data$projects)
goodprojvalues <- c(projsscaledbymax[-c(3,5)], projsscaledbymax[c(3,5)])
MakeACartogram(tomsshapedata, c(1,2,4,6,7,8,9,10,11,12,13,14,15,16,3,5),  goodprojvalues,   hsv(1,goodprojvalues,1),  2.5,  8)

demo(synthetic, package="Rcartogram")
install.packages("devtools")




