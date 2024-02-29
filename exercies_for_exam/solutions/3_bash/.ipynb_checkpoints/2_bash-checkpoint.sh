#!/bin/bash

FILE_CSV="data.csv"
FILE_TXT="data.txt"

grep -v "^#" $FILE_CSV > $FILE_TXT 

sed -i "s/,//g" $FILE_TXT 

# count even and odd numbers

EVEN_NUMBERS=0
ODD_NUMBERS=0

for n in $(cat $FILE_TXT); do
  if (( n % 2 == 0 )); then
    EVEN_NUMBERS=$((EVEN_NUMBERS + 1))
  else
    ODD_NUMBERS=$(( ODD_NUMBERS + 1 ))
  fi
done

echo "even numbers: $EVEN_NUMBERS; odd numbers: $ODD_NUMBERS;"

# 2.c 
BIGGER_REF=0
SMALLER_REF=0

while read line; do
  while read -a val; do
    X="${val[0]}"
    Y="${val[1]}"
    Z="${val[2]}"
    TEST=$( bc <<< "scale=4; sqrt($X^2 + $Y^2 + $Z^2)" )
    REF=$(bc <<< "scale=4; 100*sqrt(3)/2")
    if (( $(bc <<< "$TEST > $REF") )); then
      BIGGER_REF=$(( BIGGER_REF + 1 ))
    else
      SMALLER_REF=$(( SMALLER_REF + 1 ))
    fi
  done <<< "$line"
done < <(cat $FILE_TXT)

echo "the values bigger than the reference are: $BIGGER_REF; smaller are: $SMALLER_REF"

# 2.d

FOLDER="files_2"

if [ -d $FOLDER ]; then
  rm -r $FOLDER
fi

mkdir $FOLDER

N=$1
for (( i=1; i<=N; i++ )); do
  FILE_NAME="division_by_$i.txt"
  while read line; do
    while read -a val; do
      for j in ${!val[@]};do
        val[$j]=$( bc <<< "scale=3; ${val[$j]}/$i" )
      done
      echo "${val[@]}" >> $FOLDER/$FILE_NAME
    done <<< "$line"
  done < <(cat $FILE_TXT) 
done




