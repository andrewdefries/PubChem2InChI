##################
library(ChemmineR)
##################
files<-list.files(pattern="Compound.", recursive=F)
##################
DoMyWork<-function(p){
###############
sdfset<-read.SDFset(files[p])
#########################
desc <- function(sdfset) {
        cbind(SDFID=sdfid(sdfset), 
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

