#  1.  First we switch to the directory for the elections:
/class/datamine/data/election
#  and then we get the number of lines per file (this is off-by-one but that's OK here)
wc -l *.txt
#  and we get this output:
308697 itcont1980.txt
169024 itcont1982.txt
258968 itcont1984.txt
278736 itcont1986.txt
432979 itcont1988.txt
529912 itcont1990.txt
887861 itcont1992.txt
838805 itcont1994.txt
1228410 itcont1996.txt
1010008 itcont1998.txt
1694084 itcont2000.txt
1419715 itcont2002.txt
2460298 itcont2004.txt
1830340 itcont2006.txt
3357472 itcont2008.txt
2111821 itcont2010.txt
3348876 itcont2012.txt
2192152 itcont2014.txt
20557797 itcont2016.txt
21632130 itcont2018.txt
2470055 itcont2020.txt
69018140 total

#  2a.  The number of bytes stored in all of the election files, altogether, can be found as follows:
cat *.txt | wc -c
#  There are 12149395559 bytes altogether.

#  2b.  For comparison, the size of the yellow taxi cab files can be found this way:
cd /class/datamine/data/taxi/yellow
cat *.csv | wc -c
#  There are 246006104864 bytes altogether.

#  3.  First, to get the number of donations, we can do this in UNIX:
cd /class/datamine/data/election/
  wc -l *.txt >~/project1question3.txt
#  Then, in R, we can do the following:
myDF <- read.table("project1question3.txt")
plot( seq(1980,2020,by=2), myDF$V1[1:21] )
#  or we can plot the logarithms:
plot( seq(1980,2020,by=2), log(myDF$V1[1:21]) )
