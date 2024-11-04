#Project 1
#Collective Corrected Solutions

#PROBLEM 1
#-------------

which.max(diff(LakeHuron)) + 1874 #add 1 for boundary year

which(diff(LakeHuron)) == max(diff(LakeHuron)) + 1874 #add 1 for boundary year

work <- diff(LakeHuron) #takes differences
max <- max(work) #finds max value
n <- which(work==max) #finds index of max value
1874 + n #start year
1874 + n + 1 #end year

data = LakeHuron
data <- diff(data)
index <- match(max(data), data)
cat(paste(1874 + index, "to", 1875 + index))

LakeHuron #open file
diff(LakeHuron)#Take the differences between columns
v<-c(diff(LakeHuron)) #set diff(LakeHuron) into vector
v #call vector #check to make sure it works
max(v)#find max
1874 + which(v==max(v))#Finding the year that belongs to max
1875 + which(v==max(v))

LakeHuron   #load data set
v<-c(LakeHuron)  #put in vector
x<-which.max(diff(v))   #find where max difference occurs
1874+x   #add to start to find years
1874+x+1


#PROBLEM 2
#----------
library(MASS)

mean(geyser$duration)
sort(geyser$duration, decreasing=TRUE)[1:10]
length(geyser$duration[geyser$duration >= 3])

#2c alternative
length(which(geyser$duration >= 3))

#2b alternative
durations<-geyser[order(geyser$duration),]
tail(durations, n=10)

#PROBLEM 3
#-----------

row.names(mtcars[which(mtcars$mpg == max(mtcars$mpg)),])
row.names(mtcars[which(mtcars$hp == max(mtcars$hp)),])
row.names(mtcars[which(mtcars$qsec == min(mtcars$qsec)),])
sum(mtcars$am == 1)
sum(mtcars$am == 1 & mtcars$cyl == 6)

row.names(mtcars[which.max(mtcars$mpg), ])
row.names(mtcars[which.max(mtcars$hp), ])
row.names(mtcars[which.min(mtcars$qsec), ])
sum(mtcars$am)
sum(mtcars$am & mtcars$cyl == 6)

#a
mpg<-mtcars[order(-mtcars$mpg),]
row.names(mpg[1,])
#b
hp<-mtcars[order(-mtcars$hp),]
row.names(hp[1,])  
#c
qsec<-mtcars[order(mtcars$qsec),]
row.names(qsec[1,]) 
#d
manual<- mtcars[ which(mtcars$am==1), ]
nrow(manual) 
#e
MC<-mtcars[ which(mtcars$am==1 & mtcars$cyl==6), ]
nrow(MC) 

#a
row.names(mtcars[which(mtcars[,1]==max(mtcars[,1])),]) #finds name of highest number in mpg in list
#b
row.names(mtcars[which(mtcars[,4]==max(mtcars[,4])),]) #finds name of highest number in horsepower list
#c
row.names(mtcars[which(mtcars[,7]==min(mtcars[,7])),])


#PROBLEM 4
#------------

state.x77[,"Population"][  state.x77[,"Population"] > state.x77[,"Population"]["Indiana"] & state.x77[,"Population"] < state.x77[,"Population"]["Pennsylvania"]  ]
state.x77[,"Area"][state.x77[,"Area"] > state.x77[,"Area"]["Indiana"] & state.x77[,"Area"] < state.x77[,"Area"]["Pennsylvania"]]

state <- state.x77
row.names(state)[state["Indiana", 1]<state[,1] & state["Pennsylvania", 1] >state[,1]]
row.names(state)[state["Indiana", 8]<state[, "Area"]& state["Pennsylvania", 8]>state[, "Area"]]

#Problem 4a
data_2 = state.x77
population = state.x77[,1]
Indiana_pop = state.x77[14,1]
Penns_pop = state.x77[38,1]
population[population > Indiana_pop & population < Penns_pop]
#Problem 4b
area = state.x77[,8]
Indiana_area = state.x77[14,8]
Penns_area = state.x77[38,8]
area[area > Indiana_area & area < Penns_area]

#PROBLEM 5
#------------

mean(abs(rnorm(1000000)))
var(abs(rnorm(1000000)))

#PROBLEM 6
#-------------

countas <- function(v) {
  length(grep("a", v))
}

#PROBLEM 7
#--------------

firstthree <- function(v) {
  which(v==3)[1]
}
thirdthree <- function(v) {
  which(v==3)[3]
}

firstthree <- function(v){ #creates a function called "firstthree"
  min(which(v == 3))#finds indices of the number three and prints minimum index
}
thirdthree <- function(v){  #creates a function called "thirdthree"
  three <- which(v==3)#finds indices of the number "3" and puts them in a vector
  three[3]#prints third index of the vector
}
thirdtime<-function(v){grep(3,v)[3]} 
firsttime<-function(v){grep(3,v)[1]}


#PROBLEM 8
#---------------

topfive <- function(v) {
  sort(table(v), decreasing=TRUE)[1:5]
}

topfive <- function(v) { #creates a function called "topfive"
  mode <- sort(table(v), decreasing=TRUE) #creates a table of values,
  #sorts by mode, stores as "mode"
  head(mode,5) #prints first 5 values with highest mode
}

topfive <- function(v) {
  sort(summary(factor(x)),decreasing=T)[1:5] 
}


#PROBLEM 9
#------------

sum(1/factorial(0:100))
sqrt(6*sum(1/((1:10000000)^2)))


#PROBLEM 10
#-------------

n <- 1000
(1:n)*(2:(n+1))/2
(1:n)*(2:(n+1))*(3:(n+2))/6



