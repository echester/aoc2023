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

while(<>) {
	chomp;
	if (/^[LR]+$/) { push @turns, split //; }
	elsif (/^(\w+)\s*=\s*\((.+)\)$/) { $nodes{$1} = [split /, /, $2]; }
}

my ($yma, $steps) = ('AAA', 0);

while ($yma ne 'ZZZ') {
	$yma = $nodes{$yma}->[index 'LR', $turns[$steps % @turns]];
	$steps++;
}

say $steps;