
rm *.sdf

worklist=(`gsutil -m ls gs://pubchem/*.sdf`)


R CMD BATCH MakeNewDb.R

rm RunLog
touch RunLog
###############################
for i in "${worklist[@]}" 

do
###############################

echo "copying $i to local" >> RunLog

gsutil -m cp $i .

echo "extracting datablockfield of $i and embedding" >> RunLog

R CMD BATCH EmbedInChIKey.R

rm *.sdf

echo "#########################" >> RunLog

cat *.Rout >> RunLog

echo "done moving on" >> RunLog
################################
done
