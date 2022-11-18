#!/usr/bin/perl
use strict;

open (IN, "mfr3_CDS_ref_covid_ORF.fasta");

my %ref; 
my $id_ref;
my $seq_ref;

while (my $linea=<IN>){
	chomp $linea;
	if ($linea=~/^>(.+)/){
		$linea=~s/>//g;
		$id_ref=$linea;
		$seq_ref="";
	} else {
		$seq_ref.=$linea;
		$ref{$id_ref}=$seq_ref;
	}
}

foreach my $var (keys %ref){
	my $fasta=$var.".fasta";
	my $mfr1="mfr1_".$var.".fasta";
	my $mfr2="mfr2_".$var.".fasta";
	my $mfr3="mfr3_".$var.".fasta";
	my $fr2="fr2_".$var.".fasta";
	my $fr3="fr3_".$var.".fasta";
	my $out=$var.".out";
	print "$var\t$fasta\t$out\n";
	my $id_ref_seq;
	my %seq;
	my $seq_ref_all;
	#`seqkit seq -pr ./fasta/$fasta >./fasta/$mfr1`;
	#`seqkit seq -pr ./fasta/$fr2 >./fasta/$mfr2`;
	#`seqkit seq -pr ./fasta/$fr3 >./fasta/$mfr3`;
	open (FASTA, "./fasta/$fasta");
	while (my $line=<FASTA>){
		chomp $line;
		if ($line=~/^>(.+)/){
			$line=~s/>//g;
			$id_ref_seq=$line;
			$seq_ref_all="";
		} else {
			$seq_ref_all.=$line;			
			$seq{$id_ref_seq}=$seq_ref_all;
		}
	}
	open (OUT, ">$out");
	my $cont=0;
	foreach my $var2(keys %seq){
		chomp $var2;
		$cont++;
		my $str=$seq{$var2};
		my $count=$str=~tr/-/-/;
		$seq{$var2}=~s/-/N/g;
		if ($count>9){
			next;
		}
		my $iden=$var."_".$cont;
		print OUT "$iden\n$ref{$var}\n$seq{$var2}\n\n";
	}
}
