####
filecontent=( `cat "PubChemWorkList" `)
####
for t in "${filecontent[@]}"
####
do
####
gsutil cat $t > DoMe.sdf
###
R CMD BATCH PubChemInChI4Me.R
#rm *.sdf
#rm *.csv
#rm *.Rout
###
echo "$t is done"
###
done
####
#####
