#!/bash/bin

# 2.a Make a copy of the file data.csv removing the metadata and the commas between numbers; call it data.txt
WORK_DIR="/home/nicolo/Documenti/uni_second_year/LaboratoryOfComputationalPhysics/exercies_for_exam/3_bash"
cd $WORK_DIR
CSV_FILE="data.csv"
TXT_FILE="data.txt"

sed -e "s/,//g" < <(grep -v "^#" $CSV_FILE) > $TXT_FILE

# 2.b How many even numbers are there?
COUNT_EVEN=0
for n in $(cat $TXT_FILE); do
  if (( n % 2 == 0 )); then
    COUNT_EVEN=$(( COUNT_EVEN + 1 ))
  fi
done

echo "There are $COUNT_EVEN even numbers"

# 2.c Distinguish the entries on the basis of sqrt(X^2 + Y^2 + Z^2) is greater or smaller than 100*sqrt(3)/2. Count the entries of each of the two groups
COUNT_SMALLER=0
COUNT_BIGGER=0

while read line; do
  while read -a aline; do
    X=${aline[0]}
    Y=${aline[1]}
    Z=${aline[2]}
    if (( $( bc <<< " scale=1; sqrt($X^2 + $Y^2 + $Z^2) < 100*sqrt(3)/2" ) )); then
      COUNT_SMALLER=$((COUNT_SMALLER + 1))
    else
      COUNT_BIGGER=$((COUNT_BIGGER + 1))
    fi
  done <<< "$line"
done < $TXT_FILE

echo "there are $COUNT_SMALLER lines in which sqrt(X^2 + Y^2 + Z^2) is smaller than 100*sqrt(3)/2"
echo "there are $COUNT_BIGGER lines in which sqrt(X^2 + Y^2 + Z^2) is bigger than 100*sqrt(3)/2"

# 2.d Make n copies of data.txt (with n an input parameter of the script), where the i-th copy has all the numbers divided by i (with 1<=i<=n).

if [[ "$1" -eq "" ]]; then
  echo "ERROR: For the point 2.d an integer has to be provided as first argument"
  exit
fi

if [ -f "division_by_1.txt" ]; then
  rm division_by*
fi

for (( i=1; i<=$1; i++ )); do
  OUT_FILE="division_by_$i.txt"
  while read line; do
    while read -a aline; do
      for j in ${!aline[@]}; do
        aline[$j]=$( bc <<< " scale=3; ${aline[$j]}/$i  " )
      done
      echo "${aline[@]}" >> $OUT_FILE
    done <<< "$line"
  done < $TXT_FILE
done


