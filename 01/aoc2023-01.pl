#!/usr/bin/perl
#
# aoc2023-01
#
# advent of code 2023 | ed chester | @bocs@twt.cymru
# day 1
#
# "it's easy to be enthusiastic at this point."
# 
# Massive props to Eric W for another year of near-insanity in the 
# pursuit of superior code skillz.
#

use strict;
use warnings;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';
open (INF, '<', $infile) || die "$!\n";

my $c=0;
while(<INF>) {
	chomp;

	# part 2 enable
	if(1){
	s/one/o1e/g;
	s/two/t2o/g;
	s/three/t3e/g;
	s/four/f4r/g;
	s/five/f5e/g;
	s/six/s6x/g;
	s/seven/s7n/g;
	s/eight/e8t/g;
	s/nine/n9e/g;
	}
	
	s/[a-z]//gi;
	my $f = substr $_, 0, 1;
	my $l = substr $_, -1, 1;
	$c += "$f$l";

}
close INF;
print $c;
