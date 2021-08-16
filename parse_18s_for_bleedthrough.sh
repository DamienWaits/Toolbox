#Requires .table files and an NGS_dump.txt file(our database). Pull bleedthrough out, based on flowcell ID and lanes.
for file in *.table
source=`awk -F "_" '{print $1;exit;}' $file`
flowcell=`grep $source NGS_dump.txt | awk '{print $14}'`
lane=`grep $source NGS_dump.txt | awk '{print $15}'`
grep $flowcell NGS_dump.txt | grep $lane | awk '{print $4}' | grep -v $source > temp.txt
while read line
do
echo $line
grep $line $file > Bleedthrough/testing.txt
done < temp.txt
