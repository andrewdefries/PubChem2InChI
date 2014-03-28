#####
rm RunLog

#####
R CMD BATCH CreatNewTable.R

####
filecontent=( `cat "PubChemWorkList" `)
####
for t in "${filecontent[@]}"
####
do
####
gsutil cat $t > DoMe.sdf
###
echo "Begin ap enumeration of $t"

R CMD BATCH PubChemInChI4MeA.R

echo "$t is done with sdfstream"


R CMD BATCH PubChemInChI4MeB.R
#rm *.sdf
#rm *.csv
#rm *.Rout
###
echo "$t is done w db commit"
##
cat PubChemInChI4MeA.Rout >> RunLog
cat PubChemInChI4MeB.Rout >> RunLog

###
done
####
#####
