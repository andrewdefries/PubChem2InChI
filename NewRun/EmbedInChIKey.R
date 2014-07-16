rm(list=ls())
###################
library(RSQLite)
library(ChemmineR)
###################

##system("gsutil -m cp gs://pubchem/Compound_000000001_000025000.sdf .")

files<-list.files(pattern=".sdf", recursive=F)

sdfset<-read.SDFset(files[1])
#valid <- validSDF(sdfset); sdfset <- sdfset[valid]

pcid<-datablocktag(sdfset, tag="PUBCHEM_COMPOUND_CID")
keyz<-datablocktag(sdfset, tag="PUBCHEM_IUPAC_INCHIKEY")

#dataTable<-data.frame(table, header=T)
#dataTable<-data.frame(keyz, header=T)
dataTable<-cbind(pcid, keyz)

colnames(dataTable)<-c("PCID", "PubchemIUPAC_InChIKey")
dataTable<-data.frame(dataTable, header=T)

#R style insert call
sql <- paste("INSERT INTO PubChemInChIKey VALUES ($PCID, $PubchemIUPAC_InChIKey)", sep="")

con <- dbConnect(SQLite(), dbname="PubChemInChIKey.sqlite")

dbBeginTransaction(con)


dbGetPreparedQuery(con, sql, bind.data = dataTable)

dbCommit(con)

dbDisconnect(con)

####################
rm(list=ls())

