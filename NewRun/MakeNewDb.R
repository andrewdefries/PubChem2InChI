###################
library(RSQLite)
library(ChemmineR)
###################
system("rm *.sqlite")

##create  a new db
con <- dbConnect(SQLite(), dbname="PubChemInChIKey.sqlite")

#make tables and specify data type
dbSendQuery(conn = con,
       "CREATE TABLE PubChemInChIKey
        (PCID INTEGER,
        PubchemIUPAC_InChIKey CHARACTER)")

dbBeginTransaction(con)
dbCommit(con)
dbDisconnect(con)

#db is made now populate it
##########################################

