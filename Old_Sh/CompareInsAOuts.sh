#Worklist
gsutil ls gs://pubchem/*.sdf | sed 's/.sdf//g' | sed 's/pubchem//g' > Target

#Output from workers
gsutil ls gs://swapmeet/*.csv | sed 's/.csv//g' | sed 's/swapmeet//g' > Output

#Number of files remaining
comm -3 Target Output | wc

echo "That is the number remaining"
echo "That is the number remaining"
echo "That is the number remaining"

#Use remaining files as worklist
comm -3 Target Output > Remainder

#Clean worklist to use as input
cat Remainder | sed 's/gs:\/\/\//gs:\/\/pubchem\//g' | sed 's/0$/0.sdf/g' > RemainderWorklist

cat RemainderWorklist  | wc





