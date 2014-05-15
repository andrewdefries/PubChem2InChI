##################
library("ChemmineR")
##################

rm(list=ls())
p<-1
files<-list.files(pattern=".sdf", recursive=F)
##################
#db <- dbConnect(SQLite(), dbname="PubChemInChI.sqlite")
sdfset<-read.SDFset(files[p])
##################
valid <- validSDF(sdfset)
sdfset <- sdfset[valid]
apset<-sdf2ap(sdfset)
sdfset<-sdfset[!sapply(as(apset,"list"),length)==1]
#cid(sdfset)<-datablocktag(sdfset, tag="PUBCHEM_COMPOUND_CID")
#smiset<-sdf2smiles(sdfset)
###################
desc <- function(sdfset) {
###################
###################
	      cbind(SDFID=cid(sdfset),
              #datablock2ma(datablocklist=datablock(sdfset))[,12:14],
              ###############
              #MW=MW(sdfset),
              #groups(sdfset),
              #AP=sdf2ap(sdfset, type="character"),
              #APFP=desc2fp(x=sdf2ap(sdfset), descnames=1024, type="character")
              PCID=datablocktag(sdfset, tag="PUBCHEM_COMPOUND_CID"),
	      ############# 
              IUPAC_OpenEyeName=datablocktag(sdfset, tag="PUBCHEM_IUPAC_OPENEYE_NAME"),
              IUPAC_CAS_Name=datablocktag(sdfset, tag="PUBCHEM_IUPAC_CAS_NAME"),
              IUPAC_Name=datablocktag(sdfset, tag="PUBCHEM_IUPAC_NAME"),
              IUPAC_SystematicName=datablocktag(sdfset, tag="PUBCHEM_IUPAC_SYSTEMATIC_NAME"),
              IUPAC_TraditionalName=datablocktag(sdfset, tag= "PUBCHEM_IUPAC_TRADITIONAL_NAME"),
              InChi=datablocktag(sdfset, tag="PUBCHEM_IUPAC_INCHI"),
              InChiKey=datablocktag(sdfset, tag="PUBCHEM_IUPAC_INCHIKEY"),
              OpenEyeCanSmiles=datablocktag(sdfset, tag="PUBCHEM_OPENEYE_CAN_SMILES"),
              OpenEyeISOSmiles=datablocktag(sdfset,tag="PUBCHEM_OPENEYE_ISO_SMILES")#,
             ##BabelSmiles=as.vector(as.character(smiset[1:length(smiset)]))##[1:length(smiset)])    
              ##############
       )
}
########################
sdfStream(input=files[p], output=paste(gsub(".sdf", "", files[p]), ".csv", sep=""), fct=desc, Nlines=50000)
rm(list=ls())
