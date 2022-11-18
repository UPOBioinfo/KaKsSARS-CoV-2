#!/usr/bin/perl
use strict;

####Initial Blast to select the best candidate for each strain
my @list= `ls /path_to_genomes/covid*.fa`;

foreach my $base (@list){
	chomp $base;
	my $seq=$base;
	$seq=~s/(.+)\///g;
	if ($seq=~/covid_all.fna/){
	#	next;
	}
	my $out=$seq;
	$out=~s/fa/out/g;
	if (! -e "$base.nhr") {
  		`makeblastdb -in $base -dbtype nucl`;
	}
	`blastn -db $base -query CDS_ref_covid.fasta -outfmt '6 qseqid sseqid pident qcovs evalue slen sseq' -max_target_seqs 1 -out $out -num_threads 20`;
	print "$seq realizado\n";
}

`cat covid*.out > all_covid.def`;

open (IN, "all_covid.def");
my %hash_filt;
my %hash_seq;

while (my $line=<IN>){
        chomp $line;
	$line=~s/\s{1,}/\t/g;
        #print "$line\n";
        my @list=split (/\t/, $line);
        if ($list[2]>90 and $list[3]==100){
	#print "$line\n";
                $hash_filt{$list[0]}{$list[1]}=$line;
		$hash_seq{$list[0]}{$list[1]}=$list[6];
        }
}

foreach my $var1 (sort keys %hash_filt){
        my $name=$var1."_"."id";
	my $name2=$var1."."."fasta";
        #print "$name\n";
        open (OUT1, ">$name");
	open (OUT2, ">$name2");
        foreach my $var2 (keys %{$hash_filt{$var1}}){
                print OUT1 "$hash_filt{$var1}{$var2}\n";
		print OUT2 ">$var2\n$hash_seq{$var1}{$var2}\n";
        }
}
