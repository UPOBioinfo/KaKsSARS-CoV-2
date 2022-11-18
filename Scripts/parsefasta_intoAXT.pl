#!/usr/bin/perl

print "Input file = $ARGV[0]\n";
@array = <MYFILE>;
chomp @array;

$count = 0;
@seq = ();
@name = ();
$tmp_seq = "";

while ($count < @array) {
	print ".";
	if(index($array[$count], ">")==0) {
		push(@name, substr($array[$count], 1, length($array[$count])-1));
   		if ($tmp_seq ne "") {
			push(@seq, $tmp_seq);
			$tmp_seq = "";
		}	
	}
	else {
		$tmp_seq .= $array[$count];
	}
	$count++;

	if ($count==@array) {
           push(@seq, $tmp_seq);
        }

}

my $id=$ARGV[0];
$id=~s/mafft_//g;
$output = $id ."\n";
#$output  = join("-", @name)."\n";
$output .= join("\n", @seq)."\n";
$output .= "\n";

$outfile = $ARGV[0].".axt";
open(OUTFILE, ">$outfile");
print OUTFILE ($output);
