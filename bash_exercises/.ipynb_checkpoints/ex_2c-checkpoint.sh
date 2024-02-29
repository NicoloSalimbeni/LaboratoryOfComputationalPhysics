#!/bin/bash

ref=$( echo "scale=2;100*sqrt(3)/2" | bc )
echo "reference value: "$ref
greater=0
smaller=0
while read -r line; do
  read -a aLine <<< "$line"
  value=$((aLine[0]**2 + aLine[1]**2 + aLine[2]**2))
  value=$( echo "sqrt($value)" | bc)
  if (( $(bc <<< "$value > $ref") )); then
    greater=$((greater + 1))
  elif ((  $(bc <<< "$value < $ref") )); then
    smaller=$((smaller + 1))
  fi
done < data.txt

echo "grater than " $ref "--->" $greater
echo "smaller than " $ref "--->" $smaller


# while read -r line; do
#   numbers=( $(echo $line | tr -s [:space:] '\n' ) )
#   echo $numbers
#   echo "ciao"
# done < data.txt