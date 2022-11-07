#!/bin/bash
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -J MAFFT
#SBATCH -p month

#./script_transf_to_fasta.pl

module load MAFFT

module load Anaconda3/4.4.0

#./prev_kaks_def.pl

#./prev_kaks_def_new.pl

#perl toaxt.pl

./Calculate_kaks.pl

#perl Calculate_kaks_mod.pl genes00

#wc -l mafft*_new.axt >num_esp_all_CDS.txt

