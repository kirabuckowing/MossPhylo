#This program compares the size of two files - specifically, between original and resequenced files for my research, though it can be adapted beyond that as needed.
#Relies on BioPython's built in FastQ iterator

# coding: utf-8
from Bio.SeqIO.QualityIO import FastqGeneralIterator
import gzip

names = open('list.txt','r')
lines = names.read().splitlines()
for line in lines:
    print(str(line))
    iterator1 = FastqGeneralIterator(gzip.open(str(line)+'_1.fq.gz', 'rt'))
    iterator2 = FastqGeneralIterator(gzip.open(str(line)+'_2.fq.gz', 'rt'))

    with gzip.open(str(line)+'_1.fq.gz') as f1, gzip.open(str(line)+'_2.fq.gz') as f2:

        file1 = open('NEW_'+str(line)+'_r1.fq','w')
        file2 = open('NEW_'+str(line)+'_r2.fq','w')

        size1 = 0
        try:
            for i,l in enumerate(f1):
                size1 = size1 + 1
        except:
            print('UEOF')
        print('file 1 is '+str(size1)+' lines')

        size2 = 0
        try:
            for i,l in enumerate(f2):
                size2 = size2 + 1
        except:
            print('UEOF')
        print('file 2 is '+str(size2)+' lines')

        if size1 > size2:
            count = 0
            print('file 1 is larger')
            for ID1_long, Seq1, Qual1 in iterator1:
               try:
                    ID2_long, Seq2, Qual2 = next(iterator2)
                    file1.write('@' + ID1_long + '\n')
                    file1.write(Seq1 + '\n')
                    file1.write('+ \n')
                    file1.write(Qual1 + '\n')
                    file2.write('@' + ID2_long + '\n')
                    file2.write(Seq2 + '\n')
                    file2.write('+ \n')
                    file2.write(Qual2 + '\n')
               except:
                    count=count+1


        else:
            count = 0
            print('Files are the same length')
            for ID1_long, Seq1, Qual1 in iterator1:
               try:
                    ID2_long, Seq2, Qual2 = next(iterator2)
                    file1.write('@' + ID1_long + '\n')
                    file1.write(Seq1 + '\n')
                    file1.write('+ \n')
                    file1.write(Qual1 + '\n')
                    file2.write('@' + ID2_long + '\n')
                    file2.write(Seq2 + '\n')
                    file2.write('+ \n')
                    file2.write(Qual2 + '\n')
               except:
                    count=count+1

        count=count*4

        print('The files differ by '+str(count)+' lines.')
