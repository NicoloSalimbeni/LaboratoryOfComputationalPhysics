#!/bin/bash

linenumber=0
while read -r line; do
  linenumber=$(( linenumber + 1 ))
  filename=$(( linenumber % 18))
  echo $line >> ./ex_1e_files/$filename.txt
done < LCP_22-23_students.csv