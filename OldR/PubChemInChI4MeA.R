##################
library("ChemmineR")
##################
library("RSQLite")
p<-1
files<-list.files(pattern=".sdf", recursive=F)
##################
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
write.SDF(sdfset, file=files[p], cid=F, sig=T)
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
sdfStream(input=files[p], output=paste(gsub(".sdf", "", files[p]), ".csv", sep=""), fct=desc, Nlines=10000)



