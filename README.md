# MossPhylo
Codes used in my graduate research under Dr. Matt Johnson, Texas Tech Biological Sciences (https://github.com/mossmatters).

My work focused on phylotranscriptomic analysis of (Illumina HiSeq NGS) files for ~90 new plerocarpous (creeping) mosses, with the goal to update previously published research regarding species diversity in the second largest group of plants. Work is still ongoing.

Files cover the different steps of the process, including:
1. Quality checks with FastQC (not included here)
2. Quality trimming and sequencing adapter removal with Trimmomatic
3. De novo assembly with Trinity
4. Translation, ORF recognition and blast searches with Transdecoder
5. Clustering for excess isoform removal with CD-HIT
6. Orthologous group discovery with Orthofinder
7. Multiple sequence alignment with MAFFT, combined with Initial tree creation with FastTree

Helper files for other sub-steps and helpful extras are also included for transparency.
Steps of the Ya Yang pipeline were utilized for actions around and after orthologous group discovery, starting at approximately Step 6 on their research site (https://bitbucket.org/yangya/phylogenomic_dataset_construction/src/master/)
