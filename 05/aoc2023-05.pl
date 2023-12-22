#!/usr/bin/perl
# aoc2023-05
#
# "
# somedays, looking out over the field of seeds and gardening
# materials and junk, elves arsing around with maps instead of
# actually doing the work, one thinks to oneself, 'I shouldn't
# have to build an array of arrays to organise this lot.
# Hashtag justsayin'.
# "

use 5.032;
use strict;
use warnings;
use List::Util qw| min |;

my @seeds;
my @maps;

my @rules;
while(<>) {
	chomp;
	if (/^seeds.+?([\d\s]+)$/i) {
		push @seeds, split ' ', $1;
	}
	elsif (/^(\d+)\s(\d+)\s(\d+)$/) {
		push @rules, [$2, $2+$3-1, $1-$2];
	}	
	else {
		if (@rules) { push @maps, [@rules]; }
		@rules = ();
	}
}
# catch last set: really ought to make a cleaner way to do this, but cba
if (@rules) { push @maps, [@rules]; }

# part 1
my @locs;
for my $seed (@seeds) {
	foreach my $m (@maps) {
		my @transforms = $m->@*;
		foreach my $rule (@transforms) {
			my @r = $rule->@*;
			if ( ($seed >= $r[0]) && ($seed <= $r[1]) ) {
				$seed += $r[2];
				last;
			}
		}
	}
push @locs, $seed;
}

say min(@locs);
