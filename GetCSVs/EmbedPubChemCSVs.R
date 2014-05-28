###################
library(RSQLite)
###################

files<-list.files(pattern=".csv", recursive=F)

p<-1

InChIxls<-list.files(pattern=".csv", recursive=F)
##
table<-read.csv(InChIxls[p], header=T, sep="\t")
#table<-read.delim(InChIxls[p], row.names=1)
#
TableName<-gsub(".sdf", "", files[p])
###
#load table dataTable
dataTable<-data.frame(table, header=T)

#source("Open.R")
###
con <- dbConnect(SQLite(), dbname="PubChemInChI.sqlite")
#open con


colnames(dataTable) <- c("CID", "SDFlineStart", "SDFlineEnd", "PCID", "PubchemIUPAC", "PubchemIUPAC_InChI", "PubchemIUPAC_InChIKey")

#R style insert call
sql <- paste("INSERT INTO PubChemInChI VALUES ($CID, $SDFlineStart, $SDFlineEnd, $PCID, $PubchemIUPAC, $PubchemIUPAC_InChI, $PubchemIUPAC_InChIKey)", sep="")

dbBeginTransaction(con)


dbGetPreparedQuery(con, sql, bind.data = dataTable)

dbCommit(con)

dbDisconnect(con)
