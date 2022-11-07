#!/usr/bin/perl
use strict;

###./getfasta.pl lista_final_id_85.txt ultrafaa.fa >fasta_85.fa

my %pat;
my $flag;
open in, $ARGV[0];
while (<in>) {
  chomp;

  $pat{$_} = 1;
}
close in;

open file, $ARGV[1];
while (<file>) {
  chomp;

  if (/^>([^ ]+) ?/) {
    my $id = $1;
    $flag = 0;
#print "$id\n";
    if ($pat{$id}) {
	my $id2=$id;
	#$id2=~s/_(.+)//g;
      print ">$id2\n";
      $flag = 1;
    }
  } elsif ($flag == 1) {
    print;
    print "\n";
  }
}
close file;
