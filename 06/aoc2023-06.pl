#!/usr/bin/perl
# aoc2023-06
#
# "
# it it wasn't for this bOAt rAcE i would have given up today
# "
 
use strict;
use warnings;

my (@t,@d);
my $ways = 1;

while(<>) {
	if(0) { s/\s+//g; } # part 2 switch
	if (/^T.+?([\d\s]+)$/) { push @t, split ' ', $1; }
	elsif (/^D.+?([\d\s]+)$/) { push @d, split ' ', $1; }
}

$ways *= w2w($t[$_], $d[$_]) for(0..$#t);
print $ways;

sub w2w {
	my ($t, $d) = @_;
	my $w = 0;
	for (my $p=0; $p<=$t; $p++) { $w++ if ($p*($t-$p) > $d); }
	return $w;
}
