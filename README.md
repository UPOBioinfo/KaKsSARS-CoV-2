# KaKs SARS-CoV-2

### Scripts for the paper "The most exposed regions of SARS-CoV-2 structural proteins are subject to strong positive selection, although gene overlap may locally modify this behavior"

In this work we have been able to measure the selective pressure of all the described SARS-CoV-2 genes, even analyzed by sequence regions, and we show how this type of analysis allows us to separate the genes between those subject to positive selection (usually those that code for surface proteins or those exposed to the host immune system) and those subject to negative selection because they require greater conservation of their structure and function. 

Package: MAFFT v7.305, BLAST v2.9.0+, Statistics::Basic (CPAN), KaKs_Calculator v2.0, SeqKit v0.15

## Scripts:

# Initial_Blast.pl
Search for the initial sequences in each SARS-CoV-2 strains (set path to genomes). 

# First_step_kaks.pl
Create the alignments in all frames.

# getfasta.pl
Extract sequences from a file.

# parsefasta_intoAXT.pl
Transform alignments files to .axt format.

# Second_step_kaks.pl
Calculate the KaKs ratio of .axt alignment.

# SlidingWindow.pl
Create the input files for the sliding window analysis. After, use Second_step_kaks.pl script.

./SlidingWindow.pl align.axt window_size (57) step_size (9)



# percent_mut.pl
Calculate the number of changes per codon position for ORF+1 (set a specific reference sequence).

./percent_mut.pl align.axt


Incluir breve descripción metodologia
