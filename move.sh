#Simple program to move all files within a list to another directory. Adjustable as needed for different steps of the process or different moving needs.

#!/bin/bash

#Set this to your desired file, listing the ID's you would like to iterate over within a directory.
file="/scratch/user/allMosses/IDs.txt"
echo
while read -r line;
do
cp /scratch/user/oldDirectory/${line}/${line}.fasta /scratch/kbuckowi/newDirectory
done < "$file"
