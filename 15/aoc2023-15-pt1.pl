#!/usr/bin/perl
# aoc2023-15-pt1
#
# "
# This is way too suspiscious. We're screwed. 
# "

my $sum = 0;

while(<>) {
	chomp;
	$sum += hash($_) foreach split /,/;
}

print $sum;

sub hash {
	my $v = 0;
	foreach my $c (split //, shift) {
		$v += ord $c;
		$v *= 17;
		$v %= 256;
	}
	return $v;
}
