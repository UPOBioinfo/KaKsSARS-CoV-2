#!/usr/bin/perl
use strict;

my $axt=$ARGV[0]; 

open (IN, "$axt");

my $seq_ref="atgggctatataaacgttttcgcnttttccgtttacgatatatagtctactcttgtgcagaatgaattctcgtaactacatagcacaagtagatgtagttaactttaatctcacatag"; #set reference sequence


my @ref=split (//, $seq_ref);

my $total_1=0;
my $total_2=0;
my $total_3=0;
my %hash;

while (my $line=<IN>){
	chomp $line;
	if ($line=~/cds(.+)/ or $line=~/nsp(.+)/ ){
		next;
	}
	my $cont=0;
	my $pos=1;
	my @lista= split (//, $line);
	my $num=1;
	my $sum_1=0;
	my $sum_2=0;
	my $sum_3=0;
	foreach my $var (@lista){
		my $id=$ref[$cont]."_".$lista[$cont]."_".$pos;
		my $value=0;
		if ($num>3){
			$num=1;
		}
		unless ($ref[$cont]=~/$lista[$cont]/ or $lista[$cont]=~/n/){
			$value=1;
			if ($num==1){
				$hash{$num}{$id}++;
				$sum_1=$sum_1+$value;
			} elsif ($num==2){
				$hash{$num}{$id}++;
				$sum_2=$sum_2+$value;
			} elsif ($num==3){
				$hash{$num}{$id}++;
				$sum_3=$sum_3+$value;
			}
		}
		$cont++;
		$pos++;
		$num++;
	}
	$total_1=$total_1+$sum_1;
	$total_2=$total_2+$sum_2;
	$total_3=$total_3+$sum_3;
	@lista="";
}

##print ">>>$total_1\t$total_2\t$total_3\n"; ###total number of changes

foreach my $var (sort keys %hash){
	my $cont=0;
	print "$var\t";
	foreach my $cos (keys %{$hash{$var}}){
		$cont++;
	}
	print "$cont\n";
}
