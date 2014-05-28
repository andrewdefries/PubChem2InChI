###################
library(RSQLite)
###################
system("rm *.sqlite")

##create  a new db
con <- dbConnect(SQLite(), dbname="PubChemInChI.sqlite")

#make tables and specify data type
dbSendQuery(conn = con,
       "CREATE TABLE PubChemInChI
       (CID INTEGER,
        SDFlineStart INTEGER,
        SDFlineEnd  INTEGER,
        PCID INTEGER,
        PubchemIUPAC CHARACTER,
        PubchemIUPAC_InChI CHARACTER,
        PubchemIUPAC_InChIKey CHARACTER)")

dbBeginTransaction(con)
dbCommit(con)
dbDisconnect(con)

#db is made now populate it
##########################################

