#Simple program to run through all IDs and concatenate the paired and unpaired files before running Trinity.

#!/bin/bash

#Set this to your desired file, listing the ID's you would like to iterate over within a directory.
file="/scratch/user/directory/raw/IDs.txt"

echo
while read -r line;
do
cat /scratch/user/directory/output/paired/NW${line}_R1p.fq.gz /scratch/user/directory/output/unpaired/NW${line}_R1up.fq.gz > NW${line}_R1pup.fq.gz
done < "$file"
