rm *.sqlite
rm *.csv
rm *.Rout


R CMD BATCH MakeNewDb.R

####
####
filecontent=(`gsutil ls gs://swapmeet/*.csv`)
#Name=(`cat WorkList | sed 's/gs:\/\/pubchem\///g' | sed 's/\.sdf/.csv/g'`)
####
for t in "${filecontent[@]}"
####
do
####
gsutil -m cp $t .
###
echo "Insert values into sqlite from csvs"

R CMD BATCH EmbedPubChemCSVs.R

echo "$t is done with insertion"

#ls *.csv | sed 's/\.sdf/.csv/g' > Out
#Name=(`cat Out`)
        
#gsutil -m cp *.csv gs://swapmeet
cat EmbedPubChemCSVs.Rout >> RunLog

#Need a count on the RunLog

#R CMD BATCH PubChemInChI4MeB.R
#rm *.sdf
rm *.csv
rm *.Rout
###


done

gsutil -m cp *.sqlite gs://swapmeet/

echo "all done"


