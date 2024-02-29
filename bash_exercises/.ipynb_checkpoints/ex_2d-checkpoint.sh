#!/bin/bash
rm ./ex_2d_files/*

for i in $(seq $1); do
  while read -r line; do
    read -a aLine <<< "$line"
    for j in ${!aLine[@]}; do
      aLine[$j]=$( echo "scale=2;${aLine[$j]}/$i" | bc )
    done
    filename="file"$i".txt"
    echo ${aLine[@]} >> ex_2d_files/$filename 
  done < data.txt
done