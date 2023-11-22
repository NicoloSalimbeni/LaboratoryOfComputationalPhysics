#!/bin/bash

even=0
for num in $(cat data.txt); do
  if [ $(( num % 2 )) -eq 0 ]; then
    even=$((even + 1))
  fi
done
echo $even