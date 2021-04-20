#Simple program to quickly rename transdecoder output files.

#!/bin/bash

#Set this to your desired file, listing the ID's you would like to iterate over within a directory.
file="/scratch/user/allMosses/IDs.txt"

while read -r line;
do
#Navigate to corresponding folder where trimmomatic, trinity and transdecoder outputs have been moved off the cluster.
cd /scratch/user/allMosses/${line}

#Use sed to find and replace all sequence starts with the corresponding ID.
#Use awk to copy things to a new, more simply named file.
sed "s/>/>${line}-/g" ${line}.trinity.Trinity.fasta.transdecoder.pep | awk '{print $1}' > ${line}.transdecoder.pep
done < "$file"
