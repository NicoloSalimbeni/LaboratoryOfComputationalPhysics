#!/bin/bash

# a Make a new directory called students in your home. Download a csv file with the list of students of this lab from here (use the wget command) and copy that to students. First check whether the file is already there

FOLDER_BASE=/home/nicolo/Documenti/uni_second_year/LaboratoryOfComputationalPhysics/exercies_for_exam/3_bash
FOLDER_STUDENTS="students"
FILE_NAME="LCP_22-23_students.csv"

if [ ! -d "$FOLDER_BASE/$FOLDER_STUDENTS" ]; then
  mkdir $FOLDER_BASE/$FOLDER_STUDENTS
fi

cd $FOLDER_BASE/$FOLDER_STUDENTS

if [ ! -f "./$FILE_NAME" ]; then
  wget https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv
fi

# 1.b Make two new files, one containing the students belonging to PoD, the other to Physics.

POD_FILE="students_pod.csv"
PHY_FILE="students_phy.csv"


tail -n +2 ./$FILE_NAME | grep "PoD" > $POD_FILE 
tail -n +2 ./$FILE_NAME | grep "Phy" > $PHY_FILE 

# 1.c For each letter of the alphabet, count the number of students whose surname starts with that letter.
# 1.d Find out which is the letter with most counts.


MAX_LETTER=""
MAX_COUNTS=0

for l in {A..Z}; do
  N=$(wc -l < <(tail -n +2 ./$FILE_NAME | grep "^$l"))  
  echo "$l: $N"
  if (( N > MAX_COUNTS )); then
    MAX_COUNTS=$N
    MAX_LETTER=$l
  fi
done

echo "The letter with most counts is $MAX_LETTER with $MAX_COUNTS counts"

# 1.e Assume an obvious numbering of the students in the file (first line is 1, second line is 2, etc.), group students "modulo 18", i.e. 1,19,37,.. 2,20,38,.. etc. and put each group in a separate file 

COUNT=0

if [ -f "Modulo_1.csv" ]; then
  rm Modulo*
fi

while read line; do
  TMP_FILE="Modulo_$(( COUNT % 18 )).csv"
  echo $line >> $TMP_FILE
  COUNT=$(( COUNT + 1))
done < <(tail -n +2 ./$FILE_NAME)
