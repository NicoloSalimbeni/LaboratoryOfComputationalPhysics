#!/bin/bash

# 2.a Make a copy of the file data.csv removing the metadata and the commas between numbers; call it data.txt

DATA_CSV="data.csv"
DATA_TXT="data.txt"

sed -e "s/,//g" < <(grep -v "^#" $DATA_CSV) > $DATA_TXT

# 2.b How many even numbers are there?
COUNT_EVEN=0

for n in $(cat $DATA_TXT); do
  if (( n % 2 == 0 )); then
    COUNT_EVEN=$((COUNT_EVEN + 1))
  fi
done
echo "There are $COUNT_EVEN even numbers in $DATA_TXT"

# 2.c Distinguish the entries on the basis of sqrt(X^2 + Y^2 + Z^2) is greater or smaller than 100*sqrt(3)/2. Count the entries of each of the two groups 

COUNT_GREATER=0
COUNT_SMALLER=0

while read line; do
  while read -a aL; do
    X=${aL[0]}
    Y=${aL[1]}
    Z=${aL[2]}
    if (( $(bc <<< "scale = 2; sqrt($X^2+$Y^2+$Z^2) < 100*sqrt(3)/2"  ) )); then
      COUNT_SMALLER=$((COUNT_SMALLER + 1))
    else
      COUNT_GREATER=$((COUNT_GREATER + 1))
    fi
  done <<< $line
done < $DATA_TXT

echo "There are $COUNT_GREATER bigger cases and $COUNT_SMALLER cases w.r.t. 100*sqrt(3)/2"

# 2.d Make n copies of data.txt (with n an input parameter of the script), where the i-th copy has all the numbers divided by i (with 1<=i<=n).

if [ -f division_1.txt ]; then
  rm division*
fi

for ((j=1;j<=$1;j++)); do
  while read line; do
    while read -a aL; do
      for i in ${!aL[@]}; do
        aL[$i]=$( bc <<< " scale = 2;  ${aL[$i]}/$j" )
      done
      echo "${aL[@]}" >> "division_$j.txt"
    done <<< $line
  done < $DATA_TXT
done