#!/usr/bin/perl
# aoc2023-09
#
# "
# part 2, are you for real? I publicly said on day 6 that that was 
# the only time part 2 would take 8 characters. Here, it took 7. 
# Foiled again. Comments added post-submission (ofc). I also added the 
# part 2 switch flag afterwards, so if you want, this is 26 characters 
# more to include both cases, which is not what i did to get the submission
# answer.
# "
 
use v5.10;
use strict;
use warnings;

my $sum = 0; # running total for all records

while(<>) {
	chomp;
	my @row = (1) ? reverse split / / : split / /; # part 2 flag
	my @nextrow = (1); # initialise the next row with a non-zero list
	my $newval = 0; # initialise the new value we need

	# loop until the differences are all zero
	while (!iszeros(\@nextrow)) {
		my $i;
		@nextrow = ();
		# store this difference
		for ($i=1; $i<=$#row; $i++) { push @nextrow, $row[$i]-$row[$i-1]; }
		# accumulate rows for this record
		$newval += $row[$i-1];
		# roll around ready to repeat
		@row = @nextrow;
	}
	# accumulate total for all input records
	$sum += $newval;
}
# output
say $sum;

sub iszeros {
	# return boolean if all elements of array are 0
	my $ar = shift;
	my $c = grep {$_==0} @$ar;
	return ($c == @$ar);
}
