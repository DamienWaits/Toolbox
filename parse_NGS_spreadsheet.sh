#Provide a list of SL numbers or some other unique identifier and the script will return flowcell and lane information for those samples.
#Usage: parse_NGS_spreadsheet.sh <NGS_dump_file.csv>
grep -f list.txt $1 > temp_dump.txt
awk -F ',' '{print $4,"\t",$5,"\t",$22,"\t",$23}' temp_dump.txt > temp_info.tsv	
sort -t$'\t' -k3,3 -k4,4 temp_info.tsv > Lane_information.tsv
rm -f temp_dump.txt
rm -f temp_info.tsv
