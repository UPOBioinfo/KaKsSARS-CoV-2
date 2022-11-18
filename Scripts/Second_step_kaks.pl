#!/usr/bin/perl
use strict;

my @lista= `ls mafft*axt`; ####Select .axt files

foreach my $aa (@lista){
	chomp $aa;
	my $result="result_".$aa;
	`KaKs_Calculator -c 1 -i $aa -o $result`;
	print "$aa calculado\n";
	open (IN, "$result");
	open (OUT, ">>OUT_def");
	while (my $line=<IN>){
		chomp $line;
		if ($line=~/(.+)/){
			print OUT "$line\n";
		}
	}
	close OUT;
	close IN;
}

open (IN2, "OUT_def");

my $mframe1;
my $mframe2;
my $mframe3;
my $frame1;
my $frame2;
my $frame3;
my $cont_1;
my $cont_2;
my $cont_3;
my $mcont_1;
my $mcont_2;
my $mcont_3;
my @frame1;
my @frame2;
my @frame3;
my @mframe1;
my @mframe2;
my @mframe3;
my $num;

while (my $line=<IN2>){
	chomp $line;
	my @lista=split (/\t/, $line);
	if ($lista[0]=~/covid(.+)/ and $lista[0]=~/(.+)_fr3/){
		if ($lista[4]=~/NA/ or $lista[4]=~/-nan/){
                next;
                }
		$num=$lista[4];
		$num=~s/NA/0/g;
		$num=~s/\-nan/0/g;
		$frame3+=$num;
		push (@frame3, $num);
		$cont_3++;
	} elsif ($lista[0]=~/covid(.+)/ and $lista[0]=~/(.+)_fr2/){
                if ($lista[4]=~/NA/ or $lista[4]=~/-nan/){
                next;
                }
                $num=$lista[4];
                $num=~s/NA/0/g;
		$num=~s/\-nan/0/g;
		$frame2+=$num;
		push (@frame2, $num);
		$cont_2++;
	}  elsif ($lista[0]=~/covid(.+)/ and $lista[0]=~/(.+)_mfr1/){
                if ($lista[4]=~/(.+)NA(.+)/ or $lista[4]=~/(.+)nan(.+)/){
                next;
                }
                $num=$lista[4];
                $num=~s/NA/0/g;
                $num=~s/\-nan/0/g;
                $mframe1+=$num;
                push (@mframe1, $num);
                $mcont_1++;
        }  elsif ($lista[0]=~/covid(.+)/ and $lista[0]=~/(.+)_mfr2/){
                if ($lista[4]=~/(.+)NA(.+)/ or $lista[4]=~/(.+)nan(.+)/){
                next;
                }
                $num=$lista[4];
                $num=~s/NA/0/g;
                $num=~s/\-nan/0/g;
                $mframe2+=$num;
                push (@mframe2, $num);
                $mcont_2++;
        }   elsif ($lista[0]=~/covid(.+)/ and $lista[0]=~/(.+)_mfr3/){
                if ($lista[4]=~/(.+)NA(.+)/ or $lista[4]=~/(.+)nan(.+)/){
                next;
                }
                $num=$lista[4];
                $num=~s/NA/0/g;
                $num=~s/\-nan/0/g;
                $mframe3+=$num;
                push (@mframe3, $num);
                $mcont_3++;
        }   else {
                if ($lista[4]=~/(.+)NA(.+)/ or $lista[4]=~/(.+)nan(.+)/){
                next;
                }
                $num=$lista[4];
                $num=~s/NA/0/g;
		$num=~s/\-nan/0/g;
		$frame1+=$num;
		push (@frame1, $num);
		$cont_1++;
	}
}

my $media1=$frame1/$cont_1;
my $media2=$frame2/$cont_2;
my $media3=$frame3/$cont_3;
my $mmedia1=$mframe1/$mcont_1;
my $mmedia2=$mframe2/$mcont_2;
my $mmedia3=$mframe3/$mcont_3;

my $sq_1=stdev1(@frame1);
my $sq_2=stdev2(@frame2);
my $sq_3=stdev3(@frame3);
my $msq_1=mstdev1(@mframe1);
my $msq_2=mstdev2(@mframe2);
my $msq_3=mstdev3(@mframe3);


my $std_1 = sqrt(($sq_1 / ($cont_1)));
my $std_2 = sqrt(($sq_2 / ($cont_2)));
my $std_3 = sqrt(($sq_3 / ($cont_3)));
my $mstd_1 = sqrt(($msq_1 / ($mcont_1)));
my $mstd_2 = sqrt(($msq_2 / ($mcont_2)));
my $mstd_3 = sqrt(($msq_3 / ($mcont_3)));

open (OUT2, ">Estadisticas_new.txt");

print OUT2 "Frame1\t$media1\t$std_1\n";
print OUT2 "Frame2\t$media2\t$std_2\n";
print OUT2 "Frame3\t$media3\t$std_3\n";
print OUT2 "Frame-1\t$mmedia1\t$mstd_1\n";
print OUT2 "Frame-2\t$mmedia2\t$mstd_2\n";
print OUT2 "Frame-3\t$mmedia3\t$mstd_3\n";

close OUT2;


	sub stdev1{	
        	my $sqtotal = 0;	
		my $variable2;
       		foreach $variable2(@frame1) {	
               		$sqtotal += ($media1-$variable2) ** 2;
       		}
        	return $sqtotal;	
	}

	sub stdev2{	
        	my $sqtotal = 0;	
		my $variable2;
       		foreach $variable2(@frame2) {	
               		$sqtotal += ($media2-$variable2) ** 2;
       		}
        	return $sqtotal;	
	}

	sub stdev3{	
        	my $sqtotal = 0;	
		my $variable2;
       		foreach $variable2(@frame3) {	
               		$sqtotal += ($media3-$variable2) ** 2;
       		}
        	return $sqtotal;	
	}

	sub mstdev1{	
        	my $sqtotal = 0;	
		my $variable2;
       		foreach $variable2(@mframe1) {	
               		$sqtotal += ($media1-$variable2) ** 2;
       		}
        	return $sqtotal;	
	}

	sub mstdev2{	
        	my $sqtotal = 0;	
		my $variable2;
       		foreach $variable2(@mframe2) {	
               		$sqtotal += ($media2-$variable2) ** 2;
       		}
        	return $sqtotal;	
	}

	sub mstdev3{	
        	my $sqtotal = 0;	
		my $variable2;
       		foreach $variable2(@mframe3) {	
               		$sqtotal += ($media3-$variable2) ** 2;
       		}
        	return $sqtotal;
	}
