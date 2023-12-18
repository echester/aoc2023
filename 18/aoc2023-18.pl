#!/usr/bin/perl
# aoc2023-18
#
# "
# A shoestring algorithm fiasco, waiting to dance until 
# nobody else is around, treading on the tiles as lightly as
# it can and hoping beyond hope that there isn't a fencepost
# or off-by-one error waiting to trip it up mid-step, poised, 
# hardly daring to breathe until the pirouette brings it, 
# burning yet silent, back to the moment of the very first leap. 
# "
#
# Elf: "Get the feckin lava in the tank."
#
 
use v5.10;
use strict;

my $lava = 0;
my $here = 0;
my $area = 1;

while(<>) {
	chomp;
	/^(\w)\s+(\d+)\s+\((.+)\)/;
	# argh have to actually name these things for part 2
	my $dir = $1;
	my $dist = $2;
	my $col = $3;

	# part 2
	if (1) {
		# grab direction
		$dir = substr $col, -1;
		$dir =~ s/0/R/;
		$dir =~ s/1/D/;
		$dir =~ s/2/L/;
		$dir =~ s/3/U/;
		# convert distance, now huge, ignoring the #
		$dist = hex substr $col, 1, -1;
	}
	$lava = process($dir, $dist);
}

say $lava;

sub process {
	my ($dir, $dist) = @_;
	my $dx = my $dy = 0;
	# yes, this could be a hash of arrays, but really, what's the sodding point?
	if ($dir eq 'R') { $dx = 1; }
	elsif ($dir eq 'L') { $dx = -1; }
	elsif ($dir eq 'U') { $dy = -1; }
	elsif ($dir eq 'D') { $dy = 1; }
	# build the delta polygon
	$here += $dx * $dist;
	$area += $dy * $dist * $here + $dist/2;
	return $area;
}
