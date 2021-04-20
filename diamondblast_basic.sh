#This program performs diamondblast searches on the combined allmosses.pep file from mass_cat_allmosses.sh.

#!/bin/bash

#-e for evalue, -k for max target seqs, -p for number of threads, -o for output file name, -q for query, -d for database
diamond blastp -d filteringProteomes -q allmosses.pep -o filteredMosses.outfmt6 -f 6 -p 50 -k 1 -e 1e-5

#Run slack_done_call.sh to let the user know that progress is being made on all files that need diamondblast searches.
bash slack_done_call.sh
