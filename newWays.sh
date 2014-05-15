#####
rm RunLog

#####
#R CMD BATCH CreatNewTable.R




####
filecontent=( `cat "PubChemWorkList"`)
####
for t in "${filecontent[@]}"
####
do
####
gsutil -m cp $t .
###
echo "Begin sdfstream enumeration of $t"

R CMD BATCH PubChemInChI4Me.R

echo "$t is done with sdfstream"

gsutil -m cp *.csv gs://swapmeet
cat PubChemInChI4Me.Rout >> RunLog

#R CMD BATCH PubChemInChI4MeB.R
rm *.sdf
rm *.csv
rm *.Rout
###

echo "$t is done w gsutil cp"
##
#cat PubChemInChI4MeB.Rout >> RunLog

###
done
####
#####
