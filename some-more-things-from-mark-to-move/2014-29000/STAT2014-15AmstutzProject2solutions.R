#PROBLEM 1
#-----------
data1 <- read.csv("http://llc.stat.purdue.edu/2014/29000/projects/saturn03.240.A.CT_2012_06_PD0.csv");
data2 <- read.csv("http://llc.stat.purdue.edu/2014/29000/projects/saturn03.820.A.CT_2012_06_PD0.csv");
data3 <- read.csv("http://llc.stat.purdue.edu/2014/29000/projects/saturn03.1300.R.CT_2012_06_PD0.csv");
  #data <- read.csv("/path/to/file.csv");
timevec1 <- strptime(data1[,1], "%Y/%m/%d %H:%M:%S");
timevec2 <- strptime(data2[,1], "%Y/%m/%d %H:%M:%S");
timevec3 <- strptime(data3[,1], "%Y/%m/%d %H:%M:%S");

#PROBLEM 2
#-----------
sort(table(diff(timevec1)), decreasing=T)[1]
mean(diff(timevec1))


#PROBLEM 3
#-----------
sum(diff(timevec1)>15)

max(diff(timevec1))
timevec[which.max(diff(timevec1))]
timevec[which.max(diff(timevec1))+1]

head(sort(diff(timevec1), decreasing=TRUE), 10)
tail(sort(diff(timevec1)), 10)

#PROBLEM 4
#-------------
plot(data1$water_electrical_conductivity)
timevec1[which(data1$water_electrical_conductivity>10)] 

timevec1[which(data1$water_temperature>20)]

plot(data1$water_salinity)

#PROBLEM 5
#-------------
sort(table(diff(timevec2)), decreasing=T)[1]
mean(diff(timevec2))

sum(diff(timevec2)>15)

max(diff(timevec2))

timevec[which.max(diff(timevec2))]
timevec[which.max(diff(timevec2))+1]

tail(sort(diff(timevec2)), 10)

plot(data2$water_temperature)#with min and max
plot(data2$water_temperature[-which.max(data2$water_temperature)]) #with min only
temp <- data2$water_temperature[-which.max(data2$water_temperature)]
plot(temp[-which.min(data2$water_temperature)]) #outliers gone


#PROBLEM 6
#-----------
mean(data1$water_temperature)
mean(data2$water_temperature)
mean(data3$water_temperature)


#PROBLEM 7
#----------
plot(data1$water_salinity)
plot(data2$water_salinity)#Apparent outlier
plot(data3$water_salinity)

#remove outlier, recheck. OK. No more outliers.
plot(data2$water_salinity[-which.max(data2$water_salinity)])

mean(data1$water_salinity)
mean(data2$water_salinity[-which.max(data2$water_salinity)])
mean(data3$water_salinity)

var(data1$water_salinity)
var(data2$water_salinity[-which.max(data2$water_salinity)])
var(data3$water_salinity)

plot(timevec3, data3$water_salinity)

start <- strptime("2012/06/06 00:00:00", "%Y/%m/%d %H:%M:%S")
end <- strptime("2012/06/12 23:59:59", "%Y/%m/%d %H:%M:%S")
timevec4 <- timevec3[timevec3 > start & timevec3 < end]
plot(timevec4, data3$water_salinity[timevec3 > start & timevec3 < end])

#PROBLEM 8
#-----------
tapply(data1$water_temperature, cut(data1$water_temperature, breaks=c(seq(10,18,by=2))), length)/length(data1$water_temperature)


#PROBLEM 9
#-----------
c1 <- strptime("2012/06/01 00:00:00", "%Y/%m/%d %H:%M:%S")
c2 <- strptime("2012/06/07 23:59:59", "%Y/%m/%d %H:%M:%S")
c3 <- strptime("2012/06/14 23:59:59", "%Y/%m/%d %H:%M:%S")
c4 <- strptime("2012/06/21 23:59:59", "%Y/%m/%d %H:%M:%S")
c5 <- strptime("2012/06/28 23:59:59", "%Y/%m/%d %H:%M:%S")
tapply(data1$water_temperature, cut(timevec1, breaks=c(c1, c2, c3, c4, c5), include.lowest=T), mean)

#PROBLEM 10
#------------
tapply(data3$water_salinity, list(cut(data3$water_salinity,breaks=c(0,12,1000)),cut(data3$water_temperature,breaks=c(0,14,1000))), length)
