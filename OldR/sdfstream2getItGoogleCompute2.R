#################
system("gsutil ls gs://pubchem | wc > NumberOfSDFtargets")
#
system("gsutil ls gs://pubchem > PubChemWorkList")
#
#system("gsutil cat gs://pubchem/Compound_059375001_059400000.sdf > DoMe.sdf")
#system("gsutil cat gs://pubchem/Compound_059375001_059400000.sdf > DoMe.sdf")
system("gsutil cat gs://pubchem/Compound_059450001_059475000.sdf > DoMe.sdf")
#gs://pubchem/Compound_059475001_059500000.sdf
#gs://pubchem/Compound_059500001_059525000.sdf
#gs://pubchem/Compound_059525001_059550000.sdf
#gs://pubchem/Compound_059550001_059575000.sdf

##################
library(ChemmineR)
##################
#system("sudo rm *.xls")
##system("./CleanAllSDFs.sh")
##################
files<-list.files(pattern="Compound_033550001_033575000.sdf", recursive=F)
##################
initDb("PubChemInChI.db")
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
#Check file size reload
###############
#unlink("PubChemInChI.db")
###############
###############
