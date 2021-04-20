#This program filters transdecoder outputs to save only the wanted portions after blastp searches.

from Bio import SeqIO

lines = set([x.rstrip() for x in open('IDs.txt','r')])
for line in lines:
    new = open('{}/{}.filtered.fa'.format(line,line),'w')
    # Use list comprehension to get rid of the new-line character.
    # Store as a set as it is faster to search.
    wanted = set([x.rstrip() for x in open('{}/{}_filter.txt'.format(line,line),'r')])
    for record in SeqIO.parse('{}/{}.transdecoder.pep'.format(line,line),'fasta'):
            if record.id in wanted:
                SeqIO.write(record,new,'fasta')
