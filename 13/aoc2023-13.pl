#!/usr/bin/perl
# aoc2023-13
#
# "
# This day wins the award for the maximum number of commented out lines 
# (before clean-up) and the maximum amount of print debug. You should have
# seen it. It was like a BASIC program from the '80s with PRINT all over it.
# First part done quickly, then went for lunch after twting that the hamming
# distance wasn't enough to solve the problem. By the end of lunch I convinced
# myself that actually it was enough to solve the problem, for both parts! Tidy.
# Its worth noting that the solution depended upon Eric being very clever, but
# not evil: a single smudge that introduced 2 new mirrors wouldn't be caught
# by my solution.
# I went back and stripped out part 1 approach once the part 2 solution worked
# for part 1. Probably my favourite day yet.
# "
 
use v5.10;
use strict;
use warnings;

my @rows;
my $totaltotal = 0;
my $threshold = 1; # part 1 = 0; part 2 = 1

while(<>) {
	chomp;
	if (length) { push @rows, $_; next; }
	$totaltotal += process(\@rows);
	@rows = ();
}
say $totaltotal;

sub process {
	my $ar = shift;
	my $abovemirror = findTotalLinesAboveMirrorsInAllPatternsObviously($ar);
	my @matrix = transpose($ar);
	# only deal with vertical mirrors if there weren't any horizontal ones
	my $leftmirror = $abovemirror ? 0 : findTotalLinesAboveMirrorsInAllPatternsObviously(\@matrix);
	return $leftmirror + 100 * $abovemirror;
}

sub findTotalLinesAboveMirrorsInAllPatternsObviously {
	my $ar = shift;
	my @matrix = @$ar;
	my $retval = 0;
	my $maxhd = 0;
	for my $i (0..$#matrix-1) {		
		my @ab = (0..$i);
		my @be;
		foreach (@ab) { unshift @be, 1+$i+$_ if $_+$i < $#matrix; }
		# remove excess above
		while (@ab > @be) { shift @ab; }
		# loop over row pairs
		foreach (0..$#be) {
			# get hd
			my $hd = hamming($matrix[$ab[$_]], $matrix[$be[$_]]);
			# track maximum hd
			if ($maxhd < $hd) { $maxhd = $hd; }
		}
		# if we're in threshold for this row, its got a mirror under it
		$retval += $i + 1 if ($maxhd == $threshold);
		# reset the tracking
		$maxhd = 0;		
	}
	return $retval;
}

sub transpose {
	# transpose a matrix represented as an 1-d array of strings
	my $ar = shift;
	my @tm = ();
	foreach my $r (@$ar) {
		my @c = split //, $r;
		$tm[$_] .= $c[$_] foreach (0..$#c);
	}
	return @tm;
}

sub hamming {
	# get hamming distance between 2 strings
	my $diff = $_[0] ^ $_[1];
	return $diff =~ tr/\0//c;
}
