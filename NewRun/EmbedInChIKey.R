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
sql <- paste("INSERT INTO PubChemInChI VALUES ($PCID, $PubchemIUPAC_InChIKey)", sep="")

dbBeginTransaction(con)


dbGetPreparedQuery(con, sql, bind.data = dataTable)

dbCommit(con)

dbDisconnect(con)

con <- dbConnect(SQLite(), dbname="PubChemInChI.sqlite")
result<-dbGetQuery(con,"SELECT PCID, * FROM PubChemInCHI LIMIT 2")

dbDisconnect(con)
