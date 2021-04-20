#This file performs blast searches using Transdecoder, set up in as an array job to handle mutiple files at a time on a computing cluster (via the -t line).

#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N transdecoder_array
#$ -q omni
#$ -pe sm 36
#$ -P quanah
#$ -t 1-80

#Adjust the t line as needed for number of files, like 1-n

#Navigate to the directory with assembled files, ready for plast searches.
cd /cluster/scratch/user/data/transdecoder


#Variable $SGE_TASK_ID is the ID for the current task
geneID=$(head -n $SGE_TASK_ID 56.txt | tail -n 1) #ensures 1 ID at a time


#Stop the process if something goes wrong.
set -eo pipefail


#Initiate transdecoder's search for open reading frames.
TransDecoder.LongOrfs -t /cluster/scratch/user/data/trinity_out/${geneID}.trinity.Trinity.fasta

#Perform blastp searches against a premade uniprot database using the created orf files.
blastp -query ${geneID}.trinity.Trinity.fasta.transdecoder_dir/longest_orfs.pep -db uniprot_sprot -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 36 -out ${geneID}_blastp.outfmt6

#Perform an hmmscan against a premade Pfam database using the created orf files.
hmmscan --cpu 36 --domtblout ${geneID}_pfam.domtblout Pfam-A.hmm ${geneID}.trinity.Trinity.fasta.transdecoder_dir/longest_orfs.pep

#Use transdecoder's predict to retain any found hits from these initial searches.
TransDecoder.Predict -t ../trinity_out/${geneID}.trinity.Trinity.fasta --retain_pfam_hits ${geneID}_pfam.domtblout --retain_blastp_hits ${geneID}_blastp.outfmt6


#Perform another round of searches against the model genome, here Ppatens, using the retained hits file.
blastp -query ${geneID}.trinity.Trinity.fasta.transdecoder.pep -db Ppatens_318_v3.3.protein_primaryTranscriptOnly -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 36 -out ${geneID}_blastp_ppatens.outfmt6

#Make a blast database from the newly created pep file.
makeblastdb -in ${geneID}.trinity.Trinity.fasta.transdecoder.pep -dbtype 'prot'

#Perform one last blastp search using the new database and Ppatens as the query - looking for reciprocal hits.
blastp -query Ppatens_318_v3.3.protein_primaryTranscriptOnly.fa -db ${geneID}.trinity.Trinity.fasta.transdecoder.pep -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 36 -out ${geneID}_ppatens_back_blastp.outfmt6


#Move all pipeliner files for a cleaner directory.
mv pipeliner.* /cluster/scratch/user/data/transdecoder/pipeliner 


#Navigate to directory with the slack_done_call.sh file to run it and let the user know that progress is being made on all files that need blastp's.
cd /cluster/scratch/user/
bash slack_done_call.sh

