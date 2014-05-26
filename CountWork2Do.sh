Array1=(`gsutil ls gs://pubchem/*.sdf`)
Array2=(`gsutil ls gs://swapmeet/*.csv`)
Array3=()
for i in "${Array1[@]}"; do
     skip=
     for j in "${Array2[@]}"; do
         [[ $i == $j ]] && { skip=1; break; }
     done
     [[ -n $skip ]] || Array3+=("$i \n")
done
declare -p Array3 | wc
declare -p Array3 | less
