#This program performs CD-HIT clustering on filtered fasta files in order to remove isoforms that gunk up the works.

#!/bin/bash

#Set this to your desired file, listing the ID's you would like to iterate over within a directory.
file="/scratch/user/allMosses/IDs.txt"
echo
while read -r line;
do
#Call CD-HIT with desired parameters (per their website) while providing input -i, and output -o.
cd-hit -i /scratch/kbuckowi/allMosses/${line}/${line}.filtered.fa -c 0.98 -aS 0.75 -T 4 -o /scratch/kbuckowi/allMosses/${line}/${line}.cdhit.fasta -d 0
done < "$file"
