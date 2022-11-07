#!/usr/bin/perl
use strict;

open (IN, "id_covid_references.txt"); ###List of genomes
my %hash;
my %hash_id;

while (my $linea=<IN>){
	chomp $linea;
	$linea=~s/\.(.+)//g;
	my $fasta=$linea."\."."fasta";
	my $mafft="mafft"."_".$linea;
	$hash{$fasta}=$mafft;
	my $id=$linea."_"."id";
	$hash_id{$id}=$fasta;
}

foreach my $dd (keys %hash_id){
	my $oo=$hash_id{$dd};
	my $frame_2="fr2_".$hash_id{$dd};
	my $frame_3="fr3_".$hash_id{$dd};
	my $mframe_2="mfr2_".$hash_id{$dd};
	my $mframe_1="mfr1_".$hash_id{$dd};
	my $mframe_3="mfr3_".$hash_id{$dd};
	`seqkit subseq -r 2:-3 $oo >$frame_2`;
	`seqkit subseq -r 3:-2 $oo >$frame_3`;
}

foreach my $aa (keys %hash){
	my $oo=$hash{$aa};
	my $frame_2="fr2_".$aa;
	my $frame_3="fr3_".$aa;
	my $mframe_2="mfr2_".$aa;
    	my $mframe_1="mfr1_".$aa;
   	my $mframe_3="mfr3_".$aa;
	my $frame_2_r=$hash{$aa}."_fr2";
	my $frame_3_r=$hash{$aa}."_fr3";
	my $mframe_2_r=$hash{$aa}."_mfr2";
   	my $mframe_3_r=$hash{$aa}."_mfr3";
	my $mframe_1_r=$hash{$aa}."_mfr1";
	`mafft --auto --reorder --thread 20 $aa >$oo`;
	`mafft --auto --reorder --thread 20 $frame_2 >$frame_2_r`;
	`mafft --auto --reorder --thread 20 $frame_3 >$frame_3_r`;
	`seqkit seq -pr $frame_2_r >$mframe_3_r`;
	`seqkit seq -pr $frame_3_r >$mframe_2_r`;
	`seqkit seq -pr $oo >$mframe_1_r`;
}

my @lista=`ls mafft_*`;

foreach my $bb (@lista){
	`./parseFastaIntoAXT.pl $bb`;
}
