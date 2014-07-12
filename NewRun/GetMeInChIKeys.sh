
worklist=(`gsutil -m ls gs://pubchem/*.sdf`)


R CMD BATCH MakeNewDb.R

for i in "${worklist[@]}" 

do
###############################
rm RunLog
touch RunLog

echo "copying $i to local" >> RunLog

gsutil -m cp $i .

echo "extracting datablockfield of $i and embedding" >> RunLog

R CMD BATCH EmbedInChIKey.R

rm *.sdf

echo "done moving on" >> RunLog
################################
done
