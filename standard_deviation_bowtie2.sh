##Program to report standard deviation of reads mapped.
##Requires a sorted.bam file generated by samtools which should be passed to the script as parameter 1.

##Developed by Damien S. Waits. 08/16/2016


sum=0
sumMath=0

if [[ -z "$1" ]] 					#Check if parameter one is empty. If so, report proper usage and exit.
then
	echo "Usage: mapping_stats_from_bowtie2.sh <input.sorted.bam> <list_of_contigs_to_report_reads_mapped.txt(optional)>"
	exit 1
fi

samtools depth $1 > reads.txt 				#Get mapping stats from sorted.bam file.
awk '{print $3}' reads.txt > reads_values.txt 		#Only interested in number of reads mapped for summation.

while read line #Loop until no more lines in reads_values.txt.
do
	sum=$(($sum+$line)) 				#Adding reads mapped to each contig together to get total reads mapped.
done < <(tr -d '\r' < reads_values.txt)

echo $sum
positions=`wc -l reads.txt | awk '{print $1}'`		#Determine number of contigs
#positions=$(($positions - 1)) 				#Last line of reads.txt should be ignored
echo $positions
average=$(echo "$sum / $positions" | bc -l) 		#Math to determine average
echo $average

while read line
do
	coverageMinusAverage=$(echo "($line - $average)^2" | bc -l)
	echo $coverageMinusAverage
	sumMath=$(echo "$coverageMinusAverage + $sumMath" | bc -l)
	echo $sumMath
done < <(tr -d '\r' < reads_values.txt)

coverageVariance=$(echo "$sumMath/($positions-1)" | bc -l)
echo $coverageVariance
standardDeviation=$(echo "sqrt ( $coverageVariance )" | bc -l)
echo "Standard deviation is: " $standardDeviation
