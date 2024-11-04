# We will work on llc.stat.purdue.edu for this method of data analysis.
# One time things to do:

# Open a terminal on llc.stat.purdue.edu
# In your home directory, create a file called:  .my.cnf
# by typing:  touch .my.cnf
# Then change the permissions on the file to make it private for just you:
# by typing:  chmod 600 .my.cnf
# Then open the file with nano:
# by typing:  nano .my.cnf
# Then type the following two lines in the file (without an ampersand):
#     [client]
#     password="putyourpasswordhere"
# BUT of course put your password there.  NOT your Purdue Career password,
# but rather, your MySQL password that you've been using for the last week.
# Then you can save in nano by typing Control-O (for WriteOut).
# Then you can exit nano by typing Control-X (for Exit).
# You never have to do this again.  These are one-time things.

# Then open R Studio, and type:

install.packages("RMySQL")

# Now your RMySQL library will be installed.
# You never have to do this again either.

##################################################################

Here is an example of how to make calls to MySQL from inside R.

library("RMySQL")

# The following will set up a connection to the Purdue database server.
# Please use your username instead of mdw.
myconnection <- dbConnect(dbDriver("MySQL"), host="mydb.itap.purdue.edu", username="mdw", dbname="mdw")

# This will list all of your tables. They should look familiar to you.
dbListTables(myconnection)

# This is an example of how to send any type of MySQL query.
myresult <- dbSendQuery(myconnection, "SELECT * FROM TeamsFranchises;")

# We need to fetch the results from the query.
# We use the fetch command to do that.
mydata <- fetch(myresult)

# We can take a look at what was fetched:
mydata

# Here is the class of the returned object.
# It is a data.frame.
class(mydata)

# The variable myresult, on the other hand, is an object of type MySQLResult.
# You will not be able to use myresult directly.  You have to use mydata.
class(myresult)

# Here is another example.
anotherresult <- dbSendQuery(myconnection, "SELECT m.nameFirst, m.nameLast, b.yearID, b.SB, b.HR, t.name FROM Master m INNER JOIN Batting b ON m.playerID = b.playerID INNER JOIN Teams t ON b.yearID = t.yearID AND b.teamID = t.teamID WHERE b.SB >= 40 AND b.HR >= 40;")
somemoredata <- fetch(anotherresult)
somemoredata
class(somemoredata)



