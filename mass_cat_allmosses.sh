#This program copies and concatenates all transdecoder outputs into one file for diamondblast searches.

#!/bin/bash

#Set this to your desired file, listing the ID's you would like to iterate over within a directory.
file="/scratch/user/allMosses/IDs.txt"

echo
while read -r line;
do
cp /scratch/user/allMosses/${line}/${line}.transdecoder.pep /scratch/user/allMosses
done < "$file"

cat *transdecoder.pep > allmosses.pep

#To keep things clean and save space.
rm *transdecoder.pep
