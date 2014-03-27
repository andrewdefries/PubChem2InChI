#################
#system("gsutil ls gs://pubchem | wc > NumberOfSDFtargets")
#
#system("gsutil ls gs://pubchem > PubChemWorkList")
#
#system("rm *.sdf *.csv")
#
#system("gsutil cat gs://pubchem/Compound_059375001_059400000.sdf > DoMe.sdf")
#
#system("rm *.")
#system("rm *.Rout")
#system("rm *.sqlite")
##################
library("ChemmineR")
##################
library("RSQLite")
#library("sqldf")
#library("XLConnect")
##################
##################
files<-list.files(pattern=".sdf", recursive=F)
##################
db <- dbConnect(SQLite(), dbname="PubChemInChI.sqlite")
#conn=initDb("PubChemInChI.db")
#sqldf("attach 'PubChemInChI.sqlite' as new")
##################
#Let's get started
##################
DoMyWork<-function(p){
###############
#################
#system("cat PubChemWorkList[p] > DoMe.sdf")
###############
###############
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
#              datablocktag(sdfset, tag="PUBCHEM_COMPOUND_CID"),
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
sdfStream(input=files[p], output=paste(gsub(".sdf", "", files[p]), ".csv", sep=""), fct=desc, Nlines=1000)
########################
#Now that the xls file is made with your info gobble it up into an sql db
#######################
###################
###############
#read.csv.sql(InChIxls[p], sql = "CREATE TABLE PubChemInChI AS SELECT * FROM file", sep="\t", 
#quote=FALSE, row.name=TRUE, col.name=T, header=T,dbname="PubChemInChI.sqlite")
###############
###
#system("mv DoMe.xls DoMe.csv")
###
##field.types<-list(
##	CMP="CHAR",
##	SDFlineStart="INTEGER",
##	SDFlineEnd="INTEGER",
##	SDFID="INTEGER",
##	PUBCHEM_IUPAC_TRADITIONAL_NAME="CHAR",
##	PUBCHEM_IUPAC_INCH="CHARACTER",
##	PUBCHEM_IUPAC_INCHIKEY="CHARACTER")
###
########################
###ids=loadSdf(conn, sdfset)
###addNewFeatures(conn, function(sdfset)
#data.frame(MW = MW(sdfset),
#rings(sdfset,type="count",upper=6, arom=TRUE)
###data.frame(datablock2ma(datablocklist=datablock(sdfset))[,12:14])
###############
###############
###############
}
###############
p<-1##:length(files)
lapply(p, DoMyWork)
###############
#Check file size reload
###############
#unlink("PubChemInChI.db")
#### 
#####
InChIxls<-list.files(pattern=".csv", recursive=F)
##
table<-read.csv(InChIxls[p], header=T, sep="\t")
#
TableName<-gsub(".sdf", "", files[p])
###
dbWriteTable(conn=db, name=TableName, value=table, row.names=TRUE, header=TRUE, eol="\n") ##, field.types=field.types, eol="\n")
####
dbDisconnect(db)
###############
###############
