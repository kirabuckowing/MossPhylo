#WORKING FILE
#Program to calculate common stats for phylogenetic analysis, such as N50, average unigene length and number of contigs.

# coding: utf-8

import sys
from Bio import SeqIO
import math


def unigene(name):
    transcripts_by_unigene = {}
    total_contigs = 0
    for seq in SeqIO.parse(name,"fasta"):
        unigene = "_".join(seq.id.split("_")[:-1])
        if unigene in transcripts_by_unigene:
            if len(seq) > transcripts_by_unigene[unigene]:
                transcripts_by_unigene[unigene] = len(seq)
        else:
            transcripts_by_unigene[unigene] = len(seq)
        total_contigs = total_contigs + 1
    return(total_contigs, transcripts_by_unigene)


def average_unigene(unigeneDict):
    unigene_number = len(unigeneDict)
    average_length = sum(unigeneDict.values())/unigene_number
    return(average_length)
  

def n50(unigeneDict):
    unigene_number = len(unigeneDict)
    index = 0
    n50_point = math.ceil(unigene_number/2)
    sorted_unigene = sorted(unigeneDict.values())
    while index < n50_point:
        target = sorted_unigene[index]
        index = index+1
    return(target)



geneID = sys.argv[1] #use to feed ID only and open needed files
#cd /scratch/user/moss_data/geneID equivalent in Python OR just call from wherever the needed files are

#ave unigene length and n50 on Trinity assembly
path = "{}.trinity.Trinity.fasta".format(geneID)
with open(path) as f:
    (contigs, unigeneDict) = unigene(f)
    totalUnigene = len(unigeneDict)
    unigeneAve = average_unigene(unigeneDict)
    unigeneN50 = n50(unigeneDict)
print("{}\t{}\t{}\t{}\n".format(contigs,totalUnigene,unigeneAve,unigeneN50)
#Move these after the other stats once they are figured out below


#OHR and RBH with blastp/hmm files once figured out
#More function calls here once they are figured out
