#!/usr/bin/perl
# aoc2023-04-pt1
use strict;
use warnings;
my $total = 0;
while(<>) {
	chomp;
	my @wins;
	my $score = 0;
	/^.+:\s*(.+)\|\s*(.+)$/;
	push @wins, split /\s+/, $1;
	foreach my $n (split /\s+/, $2) {
		if(grep(/^$n$/, @wins)) {
			$score = ($score == 0) ? 1 : $score * 2;
		}
	}
	$total += $score;
}
print "$total\n";
