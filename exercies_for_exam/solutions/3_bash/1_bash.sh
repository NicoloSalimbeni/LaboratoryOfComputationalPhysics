#!/bin/bash

# 1.1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

STUDENTS_DIR=/students

echo ""

# 1.1 check if the file and the folder are already there, if not create the folder and download the file
if [ ! -d "$SCRIPT_DIR$STUDENTS_DIR" ]; then
  echo "the folder $SCRIPT_DIR$STUDENTS_DIR can't be found, creating it."
  mkdir $SCRIPT_DIR$STUDENTS_DIR
else
  echo "The folder $SCRIPT_DIR$STUDENTS_DIR is already there."
fi

cd $SCRIPT_DIR$STUDENTS_DIR
FILE=LCP_22-23_students.csv

if [ ! -f "$SCRIPT_DIR$STUDENTS_DIR/$FILE" ]; then
  echo "The file is not there, downloading it."
  wget "https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv" &> /dev/null
  echo "downloaded correctly"
else
  echo "The file $FILE was already there, nothing will be downloaded"
fi

# 1.2 make files with PoD and Physics students

POD_STUDENTS=pod_students.csv
PHY_STUDENTS=phy_students.csv
cat $FILE | grep "PoD" > $POD_STUDENTS
cat $FILE | grep "Physics" > $PHY_STUDENTS

# 1.3 and 1.4
MAX_LETTER=A
MAX_OCCURENCIE=0

for l in {A..Z}; do
  N=$(tail -n +2 $FILE | grep -c "^$l")
  echo "letter $l, occurencies: $N"

  if (( N > MAX_OCCURENCIE )); then
    MAX_OCCURENCIE=$N
    MAX_LETTER=$l
  fi
done

echo "Max occurencies for $MAX_LETTER with $MAX_OCCURENCIE occurencies"

# 1.5 group students modulo 18 accorting to the line number starting from 1
FOLDER_FILES="files"
rm -r $FOLDER_FILES
if [ ! -d $FOLDER_FILES ]; then mkdir $FOLDER_FILES; fi

COUNT=0
tail -n +2 $FILE | while read LINE; do
  MOD=$((COUNT % 18))
  FILE_NAME="modulo_$MOD.csv"
  echo "$LINE" >> $FOLDER_FILES/$FILE_NAME
  COUNT=$((COUNT + 1))
done

echo ""



