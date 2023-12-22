#!/usr/bin/perl
# aoc2023-03
#
# "no worries. its sunday."
#  ... much later (dec 21) ...
# "so ouch, missed some edge cases there for part 2. suX0r."

use 5.32.0;
use strict;
use warnings;
use List::Util qw| product |;

my @nums;
my @gears;
my @grid;

# grok input
while(<>) {
	chomp;
	push @grid, ([split //]);
}

# build model
for my $r (0 .. $#grid) {
	my ($ns, $ne, $n) = ('', '', '');
	my $rr = $grid[$r];
	for my $c (0 .. @$rr - 1) {
	    if ($grid[$r][$c] =~ /\d/) {
	    	if ($ns eq '') { $ns = $c; }
	    	$n .= $grid[$r][$c];
	    }
	    else {	    	
	    	# part 2 - get gears
	    	if ($grid[$r][$c] =~ /\*/) {
		    	push @gears, [$r, $c];
		    }	    	
	    	if (($ns ne '') && ($ne eq '')) {
	    		$ne = $c - 1;
	    		push @nums, [$n, $r, $ns];
	    		($ns, $ne, $n) = ('', '', '');
	    	}
	    }
	}
	# catch right edges to end numbers
	if (($ns ne '') && ($ne eq '')) {
	    push @nums, [$n, $r, $ns];
	}
}

# part 1
my $t = 0;
$t += $_->[0] * hassymbol($_->[1], $_->[2], length $_->[0]) foreach (@nums);
say $t;

# part 2
$t = 0;
foreach (@gears) {
	my ($gr, $gc) = ($_->[0], $_->[1]);
	my @rats;
	foreach my $n (@nums) {
		if (inrange($n->[1], $gr-1, $gr+1)) {
			push @rats, $n->[0] if (inrange($gc, $n->[2] - 1, $n->[2] + length $n->[0]));
		}
	}
	if (@rats == 2) { 
		$t += product(@rats);
		@rats = ();
	}
}

say $t;

sub hassymbol {
	my ($nr, $nc, $nl) = @_;
	for my $rrange (-1 .. 1) {
        for my $crange  (-1 .. $nl) {
            if ($grid[$nr+$rrange][$nc+$crange] && $grid[$nr+$rrange][$nc+$crange] =~ /[^\.\d]/) {
				return 1;
            }
        }
    }
    return 0;
}

sub inrange {
	my ($val, $min, $max) = @_;
	return ( ($val >= $min) && ($val <= $max) );
}
