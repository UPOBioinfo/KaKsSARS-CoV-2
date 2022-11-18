# KaKs SARS-CoV-2

### Scripts for the paper "The most exposed regions of SARS-CoV-2 structural proteins are subject to strong positive selection, although gene overlap may locally modify this behavior"

In this work we have been able to measure the selective pressure of all the described SARS-CoV-2 genes, even analyzed by sequence regions, and we show how this type of analysis allows us to separate the genes between those subject to positive selection (usually those that code for surface proteins or those exposed to the host immune system) and those subject to negative selection because they require greater conservation of their structure and function. 

##Scripts:

#Initial_Blast.pl, script used to perform the search for the initial sequences in each SARS-CoV-2 strains (set path to genomes). 

./Initial_Blast.pl 

#percent_mut.pl, this script is useful to calculate the number of changes per codon position for ORF+1 (set a specific reference sequence)

./percent_mut.pl align.axt


Incluir breve descripción metodologia

Packages:

MAFFT 
BLAST
Statistics::Basic
seqkit
KaKs_Calculator
