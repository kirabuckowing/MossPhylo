#This program performs quality trimming on raw Illumina HiSeq files using Trimmomatic.

#!/bin/bash

#Set this to your desired file, listing the ID's you would like to iterate over within a directory.
file="/scratch/user/folder/IDfile.txt"

echo
while read -r line;
do
#Call trimmomatic, paired end, over the desired raw files. 
#Ouptput files are split between paired and unpaired, which have 50 in the name here due to the minimum length being set at such.
#Illumina adapters are removed before quality trimming occurs, adjust the ILLUMINACLIP path as needed.
trimmomatic PE -phred33 ./raw/${line}_R1_001.fastq.gz ./raw/${line}_R2_001.fastq.gz ./output/paired/${line}_50_R1p.fastq.gz ./output/unpaired/${line}_50_R1up.fastq.gz  ./output/paired/${line}_50_R2p.fastq.gz ./output/unpaired/${line}_50_R2up.fastq.gz ILLUMINACLIP:/home/user/utils/TruSeq3-PE-2.fa:2:30:10 LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:50;
done < "$file"
