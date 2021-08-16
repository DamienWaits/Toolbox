#Adds parameter 1 to the beginning of all lines containing @M00 and parameter 2 to the end of these lines in file parameter 3.
sed '
/@M00/ {
	n
	s/^/'"$1"'/
	s/$/'"$2"'/
}' $3
