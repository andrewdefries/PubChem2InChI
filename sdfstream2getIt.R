##################
library(ChemmineR)
##################
#system("sudo rm *.xls")
##system("./CleanAllSDFs.sh")
##################
files<-list.files(pattern="Compound*.sdf", recursive=F)
##################

##################
DoMyWork<-function(p){
###############
sdfset<-read.SDFset(files[p])
##################
###################
sdfset
valid <- validSDF(sdfset)
sdfset <- sdfset[valid]
apset<-sdf2ap(sdfset)
sdfset<-sdfset[!sapply(as(apset,"list"),length)==1]
sdfset
###################
conn=initDb("PubChemInChI.db")
###################
desc <- function(sdfset) {
        cbind(SDFID=sdfid(sdfset), 
              #datablocktag(sdfset, tag="PUBCHEM_COMPOUND_CID"),
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
sdfStream(input=files[p], output=paste(gsub(".sdf", "", files[p]), ".xls", sep=""), fct=desc, Nlines=1000)
########################
###############
}
###############
p<-1:length(files)
lapply(p, DoMyWork)
###############
unlink("PubChemInChI.db")
