#!/usr/bin/perl
use strict;
#use Statistics::Basic qw(:all);

my @lista=`ls ./results_PN/*_out`; ###PATH to splitted results

print "Sequence	Method	Ka	Ks	Ka/Ks	P-Value(Fisher)	Length	S-Sites	N-Sites	Fold-Sites(0:2:4)	Substitutions	S-Substitutions	N-Substitutions\n";

my %hash;

foreach my $var (@lista){
	chomp $var;
	open (IN, "$var");
	my @ka="";
	my @ks="";
	my @kaks="";
	my @pvalue="";
	my @subs="";
	my $id;
	my $MT;
	my $len;
	my @ssites="";
	my @nsites="";
	my @fold="";
	my @ssub="";
	my @nsub="";
	while (my $linea=<IN>){
		chomp $linea;
		my @list=split (/\t/, $linea);
		$id=$list[0];
		if ($id=~/(.+)fr(.+)/ or $id=~/fr(.+)/){
			$id=~s/_[0-9]{1,}//g;
		} else {
			$id=~s/_(.+)//g;
		}
		my $sub=$list[10];
		if ($list[4]>10){
			$list[4]=10;
		}
		if ($sub==0){
			$list[2]=0;$list[3]=0;$list[4]=0;$list[5]=0;$list[7]=0;$list[8]=0;$list[9]=0;$list[11]=0;$list[12]=0;
			next;
		}
		$MT=$list[1];
		$len=$list[6];
		push @ka, $list[2];
		push @ks, $list[3];
		push @kaks, $list[4];
		push @pvalue, $list[5];
		push @ssites, $list[7];
		push @nsites, $list[8];
		push @fold, $list[9];
		push @subs, $list[10];
		push @ssub, $list[11];
		push @nsub, $list[12];
	}
	my $med_ka= mean(@ka);
	my $med_ks= mean(@ks);
	my $med_kaks= mean(@kaks);
	my $med_pvalue= mean(@pvalue);
	my $med_ssites= mean(@ssites);
	my $med_nsites= mean(@nsites);
	my $med_fold= mean(@fold);
	my $med_subs= mean(@subs);
	my $med_ssub= mean(@ssub);
	my $med_nsub= mean(@nsub);
	my $frame;
	my $id_def;
	if ($id=~/m?fr(.+)/){
		$frame=$id;
		$id_def=$id;
		$id_def=~s/(.+)_//g;
		$frame=~s/_(.+)//g;
	} else {
		$frame="fr1";
		$id_def=$id;
	}
	print "$id\t$MT\t$med_ka\t$med_ks\t$med_kaks\t$med_pvalue\t$len\t$med_ssites\t$med_nsites\t$med_fold\t$med_subs\t$med_ssub\t$med_nsub\n";
}


sub mean {
    my (@data) = @_;
    my $sum;
    foreach (@data) {
        $sum += $_;
    }
    return ( $sum / @data );
}
sub median {
    my (@data) = sort { $a <=> $b } @_;
    if ( scalar(@data) % 2 ) {
        return ( $data[ @data / 2 ] );
    } else {
        my ( $upper, $lower );
        $lower = $data[ @data / 2 ];
        $upper = $data[ @data / 2 - 1 ];
        return ( mean( $lower, $upper ) );
    }
}
sub std_dev {
    my (@data) = @_;
    my ( $sq_dev_sum, $avg ) = ( 0, 0 );

    $avg = mean(@data);
    foreach my $elem (@data) {
        $sq_dev_sum += ( $avg - $elem )**2;
    }
    return ( sqrt( $sq_dev_sum / ( @data - 1 ) ) );
}
