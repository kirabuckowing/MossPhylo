#Simple program to separate sequences by ID and write new files for each within the concatenated allmosses file used in diamondblast.

#!/bin/bash

#Set this to your desired file, listing the ID's you would like to iterate over within a directory.
file="/scratch/kbuckowi/allMosses/IDs.txt"
echo
while read -r line;
do
#Find all matches to listed ID with grep, then write to new file.
grep ${line} filteredMosses.outfmt6 > ${line}_filtered.outmft6
done < "$file"

#Check line counts after to see if sizes are about what they are expected to be.
file="/scratch/kbuckowi/allMosses/IDs.txt"
echo
while read -r line;
do
wc -l ${line}_filtered.outmft6
done < "$file"
