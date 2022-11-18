#!/usr/bin/perl
use strict;

my $file=$ARGV[0]; ####First_step_output
my $window=$ARGV[1];####window size (57)
my $step=$ARGV[2];####step size (9)

open (IN, "$file");

my $id=$file;
$id=~s/mafft_//g; $id=~s/.axt//g;
my $cont=0;
my %hash;
my $len;
my $file_out=$id."_out";

while (my $linea=<IN>){
	chomp $linea;
	if ($linea=~/$id/){
		next
	}
	$cont++;
	$hash{$cont}=$linea;
}


open (OUT, ">$file_out");

for (my $var = 0; $var < 3846; $var= $var + $step) { ####set sequence length
	my $window_def= $var + $window - 1;
	my $num=$var+1;
	my $num_2=$window_def + 1;
	foreach my $seq (sort keys %hash){
		if ($hash{1}=~/$hash{$seq}/){
			next;
		}
		my @list=split (//, $hash{$seq});
		my @extracted_elements = @list[$var..$window_def];
		my @list_1=split (//, $hash{1});
		my @extracted_elements_1 = @list_1[$var..$window_def];
		if (@extracted_elements_1 ~~ @extracted_elements) {
			next;
		}
		print OUT "$id($num-$num_2)\n";
		print OUT "@extracted_elements_1\n@extracted_elements\n";
		@list="";
		@list_1="";
		print OUT "-\n";
	}
}

open (IN2, "$file_out");

while (my $line=<IN2>){
	chomp $line;
	if ($line=~/$id(.+)/){
		print "$line\n";
		next;
	}
	$line=~s/\s//g;
	print "$line\n";
}
