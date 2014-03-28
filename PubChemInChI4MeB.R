library(RSQLite)

files<-list.files(pattern=".sdf", recursive=F)

p<-1
InChIxls<-list.files(pattern=".csv", recursive=F)
##
table<-read.csv(InChIxls[p], header=T, sep="\t")
#table<-read.delim(InChIxls[p], row.names=1)
#
TableName<-gsub(".sdf", "", files[p])
###
#dbWriteTable(conn=db, name=TableName, value=table, row.names=TRUE, header=TRUE, eol="\n") ##, field.types=field.types, eol="\n")
####
#dbDisconnect(db)



#load table dataTable

dataTable<-data.frame(table, header=T)

con <- dbConnect(SQLite(), dbname="PubChemInChI.sqlite")
#open con

colnames(dataTable) <- c("CID", "SDFlineStart", "SDFlineEnd", "PCID", "PubchemIUPAC", "PubchemIUPAC_InChI", "PubchemIUPAC_InChIKey")


#dbSendQuery(conn = con,
#       "CREATE TABLE PubChemInChI
#       (CID INTEGER,
#        SDFlineStart INTEGER,
#	SDFlineEnd  INTEGER,
#	PCID INTEGER,
#	PubchemIUPAC CHARACTER, 
#	PubchemIUPAC_InChI CHARACTER, 
#	PubchemIUPAC_InChIKey CHARACTER)")

#con <- slot(database, "database")

sql <- paste("INSERT INTO PubChemInChI VALUES ($CID, $SDFlineStart, $SDFlineEnd, $PCID, $PubchemIUPAC, $PubchemIUPAC_InChI, $PubchemIUPAC_InChIKey)", sep="")

dbBeginTransaction(con)

dbGetPreparedQuery(con, sql, bind.data = dataTable)

dbCommit(con)

dbDisconnect(con)
