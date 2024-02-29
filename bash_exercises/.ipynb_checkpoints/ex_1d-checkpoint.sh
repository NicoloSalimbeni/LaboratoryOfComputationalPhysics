#!/bin/bash
# pay attenction the last line of the file you want to
# read must be an empty line, otherwise the real last line
# of the file will be ignored

max=0
maxletter=""
for letter in {A..Z}; do
  n=0
  while IFS= read -r line; do
    if [[ ${line:0:1} == $letter ]]; then
    n=$((n+1))
    fi
  done < LCP_22-23_students.csv
  if (( n > max )); then
    max=$n
    maxletter=$letter
  fi
done
echo "max letter is: " $maxletter "-->" $max
