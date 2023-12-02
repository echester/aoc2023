#!/usr/bin/perl
#
# aoc2023-02
#
# advent of code 2023 | ed chester | @bocs@twt.cymru
# day 2
#
# "tired already"
# 

use strict;
use warnings;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';
open (INF, '<', $infile) || die "$!\n";

my ($ar, $ag, $ab) = (12, 13, 14);
my $sumid = 0;
my $totalpower = 0;

while(<INF>) {
	chomp;
	my ($r, $g, $b) = (0, 0, 0);
	
	/^\D+(\d+)\s*:\s*(.*)$/;
	my $id = $1;
	my @handfulls = split ';', $2;

	foreach (@handfulls) {
		s/\s//g;
		my @cubes = split ',';
		foreach my $c (@cubes) {
			if    ( ($c =~ /(.+)red$/)   && ($r < $1) ) { $r = $1; }
			elsif ( ($c =~ /(.+)blue$/)  && ($b < $1) ) { $b = $1; }
			elsif ( ($c =~ /(.+)green$/) && ($g < $1) ) { $g = $1; }
		}
	}

	# part 1: accumulate ids of possible games
	if ( ($r <= $ar) && ($b <= $ab) && ($g <= $ag) ) {
		$sumid += $id;
	}

	# part 2: calculate total power
	$totalpower += $g * $r * $b;
}

close INF;
print "Part1: $sumid\n";
print "Part2: $totalpower\n";
