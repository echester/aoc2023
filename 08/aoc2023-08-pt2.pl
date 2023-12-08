#!/usr/bin/perl
# aoc2023-08
#
# "
# urgh. that's all i have to say about that. 
# "
 
use v5.10;
use strict;
use warnings;

my @turns;
my %nodes;
my @yma;

while(<>) {
	chomp;
	if (/^[LR]+$/) { push @turns, split //; }
	elsif (/^(\w+)\s*=\s*\((.+)\)$/) {
		$nodes{$1} = [split /, /, $2];
		push @yma, $1 if (substr ($1, -1) eq 'A');
		}
}

foreach my $y (@yma) {
	my $steps = 0;
	while ( (substr($y, -1, 1) ne 'Z') ) {
		$y = $nodes{$y}->[index 'LR', $turns[$steps % @turns]];
		$steps++;
	}
	say $steps;
}
print "now get LCM of these answers!\n";
