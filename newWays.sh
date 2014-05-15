#####
rm RunLog

#####
#R CMD BATCH CreatNewTable.R
gsutil ls gs://pubchem/*.sdf | sed -n '1,235p' > WorkList
#gsutil ls gs://pubchem/*.sdf | sed -n '236,470p' > WorkList1
#gsutil ls gs://pubchem/*.sdf | sed -n '471,705p' > WorkList2
#gsutil ls gs://pubchem/*.sdf | sed -n '706,940p' > WorkList3
#gsutil ls gs://pubchem/*.sdf | sed -n '941,1175p' > WorkList4
#gsutil ls gs://pubchem/*.sdf | sed -n '1176,1410p' > WorkList5
#gsutil ls gs://pubchem/*.sdf | sed -n '1411,1645p' > WorkList6
#gsutil ls gs://pubchem/*.sdf | sed -n '1646,1880p' > WorkList7
#gsutil ls gs://pubchem/*.sdf | sed -n '1881,2115p' > WorkList8
#gsutil ls gs://pubchem/*.sdf | sed -n '2116,2350p' > WorkList9
#gsutil ls gs://pubchem/*.sdf | sed -n '2351,2585p' > WorkList10
#gsutil ls gs://pubchem/*.sdf | sed -n '2586,2816p' > WorkList11

#1  236  471  706  941 1176 1411 1646 1881 2116 2351 2586


####
filecontent=(`cat "WorkList"`)
#Name=(`cat WorkList | sed 's/gs:\/\/pubchem\///g' | sed 's/\.sdf/.csv/g'`)
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

#ls *.csv | sed 's/\.sdf/.csv/g' > Out
#Name=(`cat Out`)
        
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

