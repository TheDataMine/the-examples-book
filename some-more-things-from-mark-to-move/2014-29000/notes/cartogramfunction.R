#  First, we need to install the maptools and Rcartogram packages
install.packages("XML")
install.packages("maptools")
install.packages("http://www.omegahat.org/Rcartogram/Rcartogram_0.2-2.tar.gz", repos=NULL, type="source")
library(maptools)
library(Rcartogram)

#  This is the function we will use to make cartograms in R.
MakeACartogram <- function(myshapedata, partstoplot, myvalues, mycolors, scale, boundarysize) {
  regions <- sapply(partstoplot, function(x) length(myshapedata@polygons[[x]]@Polygons))

  boundaries <- sapply(myshapedata@polygons, function(x) lapply(slot(x, "Polygons"), function(y) slot(y, "coords")) )
  statetotal <- do.call(rbind, lapply(partstoplot, function(x) do.call(rbind, boundaries[[x]])))

  xmin <- min(statetotal[,1]);  xmax <- max(statetotal[,1])
  ymin <- min(statetotal[,2]);  ymax <- max(statetotal[,2])
	
	scaledvalues <- lapply(partstoplot, function(x) lapply(boundaries[[x]], function(z)  1 + scale*(z - matrix( c(xmin, ymin), nrow=dim(z)[1], ncol=2, byrow=TRUE) ) ) )

	scaledxmax <- ceiling(1+(xmax-xmin)*scale)
	scaledymax <- ceiling(1+(ymax-ymin)*scale)

	vecx <- rep(seq(1,scaledxmax),times=scaledymax)
	vecy <- rep(seq(1,scaledymax),each=scaledxmax)

	dat <- matrix(rowSums(sapply(1:length(partstoplot), function(j) rowSums(as.matrix(sapply(1:regions[j], function(i) myvalues[j]*(point.in.polygon(vecx,vecy,scaledvalues[[j]][[i]][ ,1],scaledvalues[[j]][[i]][ ,2]) != 0) ),nrow=scaledymax )))),nrow=scaledxmax)

	big <- addBoundary(t(dat), boundarysize)
	added <- as.integer((dim(big) - dim(t(dat)))/2)
	cart <- cartogram(big)

	newvalues <- lapply(1:length(partstoplot), function(j) 
	lapply(1:regions[j], function(i) predict(cart, scaledvalues[[j]][[i]][ ,1] + added[2], scaledvalues[[j]][[i]][ ,2] + added[1] )))

  xstuff <- do.call(c, sapply(1:length(partstoplot), function(j) do.call(c, lapply(1:regions[j], function(i) newvalues[[j]][[i]]$x))))
  ystuff <- do.call(c, sapply(1:length(partstoplot), function(j) do.call(c, lapply(1:regions[j], function(i) newvalues[[j]][[i]]$y))))

	plot(NULL, type="n", xlim=range(xstuff,na.rm=T), ylim=range(ystuff,na.rm=T) )

	invisible(sapply(1:length(partstoplot), function(j) sapply(1:regions[j], function(i) polygon(newvalues[[j]][[i]]$x, newvalues[[j]][[i]]$y, 	col=mycolors[j]))))
}

