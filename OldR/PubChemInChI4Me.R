##################
library("ChemmineR")
##################
library("RSQLite")
p<-1
files<-list.files(pattern=".sdf", recursive=F)
##################
db <- dbConnect(SQLite(), dbname="PubChemInChI.sqlite")
sdfset<-read.SDFset(files[p])
##################
###################
desc <- function(sdfset) {
###################
sdfset
valid <- validSDF(sdfset)
sdfset <- sdfset[valid]
apset<-sdf2ap(sdfset)
sdfset<-sdfset[!sapply(as(apset,"list"),length)==1]
sdfset
###################
        cbind(SDFID=sdfid(sdfset),
# datablocktag(sdfset, tag="PUBCHEM_COMPOUND_CID"),
              datablock2ma(datablocklist=datablock(sdfset))[,12:14]#,
###############
              #MW=MW(sdfset),
              #groups(sdfset),
#AP=sdf2ap(sdfset, type="character"),
#APFP=desc2fp(x=sdf2ap(sdfset), descnames=1024, type="character")
#InChi=datablocktag(sdfset, tag="PUBCHEM_IUPAC_INCHI"),
#InChiKey=datablocktag(sdfset, tag="PUBCHEM_IUPAC_INCHIKEY")
##############
       )
}
########################
sdfStream(input=files[p], output=paste(gsub(".sdf", "", files[p]), ".csv", sep=""), fct=desc, Nlines=1750)



InChIxls<-list.files(pattern=".csv", recursive=F)
##
table<-read.csv(InChIxls[p], header=T, sep="\t")
#table<-read.delim(InChIxls[p], row.names=1)
#
TableName<-gsub(".sdf", "", files[p])
###
dbWriteTable(conn=db, name=TableName, value=table, row.names=TRUE, header=TRUE, eol="\n") ##, field.types=field.types, eol="\n")
####
dbDisconnect(db)
