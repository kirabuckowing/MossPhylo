#This file performs de novo assembly using Trinity, set up in as an array job to handle mutiple files at a time on a computing cluster (via the -t line).

#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N trinity_array
#$ -q omni
#$ -pe sm 36
#$ -P quanah
#$ -t 1-11

#Adjust the t line as needed for number of files, like 1-n

#Navigate to the directory with trimmed files, ready for assembly.
cd /cluster/scratch/user/data/trimmed

#Ensures 1 ID at a time is read.
#Variable $SGE_TASK_ID is the ID for the current task.
geneID=$(head -n $SGE_TASK_ID july.txt | tail -n 1) 

module load singularity

echo
#The pup files are combined read 1 paired and unpaired files, while the p files are only paired files. This was done to compare reads, with paired and unpaired joined using cat.
singularity exec -e /home/kbuckowi/trinityrnaseq.v2.9.1.simg Trinity --seqType fq --left "./${geneID}_R1pup.fq.gz" --right "./${geneID}_R2p.fq.gz" --CPU 36 --max_memory 50G --no_normalize_reads --output ${geneID}.trinity --full_cleanup

#Move all output files to new directory, separate from the trimmed files.
mv ${geneID}.* /cluster/scratch/user/data/trinity_out/

#Navigate to directory with the slack_done_call.sh file to run it and let the user know that progress is being made on all files that need assembly.
cd /cluster/scratch/user/
bash slack_done_call.sh
