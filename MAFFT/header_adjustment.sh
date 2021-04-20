#Simple program that fixes the headers of orthofinder outputs and removes * characters that can mess with MAFFT.

#!/bin/bash

#Navigate to the file within the Orthofinder results that lists wanted orthogroups - for this research, at least 20 genes, including at least 1 from model organisms.
file="/scratch/user/allMosses/FullOrthofinder/OrthoFinder/Results_Sep11/WorkingDirectory/OrthoFinder/Results_Sep19/Orthogroups/ortho_20_pc.csv"

echo
while read -r line;

#Fix the header start to match needed formatting for MAFFT.
do
#Find and replace all - with @ using sed, then print to new file.
sed "s/-/@/g" ${line}.fa | awk "{print $1}" > ${line}.fix
done

#Remove * and replace with X as needed for MAFFT.
do
#Find and replace all * with X, then print to new file.
sed "s/\*/X/g" ${line}.fix | awk "{print $1}" > ${line}_nostop.fa
done < "$file"
