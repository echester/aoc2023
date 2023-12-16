#!/usr/bin/perl
# aoc2023-15-pt1
#
# "
# slow and ugly as a maimed tortoise wearing a sketchy wig. the problem here was
# figuring out a data structure that was easier than an array of an array of hashes.
# Yes, it should have been mapped hashes all the way down, like the reindeer said, but
# i was having some syntax/sigil difficulty in the small hours.
# "
 
use v5.10;
use strict;
use warnings;

my @ins;
our @boxes;

# main loop
while(<>) {
	chomp;
	foreach my $ins (split /,/) {
		$ins =~ /^(\w+)([=-])(\d+)?$/;
		process (\@boxes, hash($1), $1, $2, $3);
	}
}

# report the total focussing power
say power(\@boxes);

sub process {
	my ($ar, $box, $label, $op, $value) = @_;
	my @thisbox = (defined $ar->[$box]) ? @{ $ar->[$box] } : ();
	foreach my $i (0 .. $#thisbox) {
		my ($l,$v) = split '_', $thisbox[$i];
		if ($l eq $label) {
			if ($op eq '=') {
				printf "Replace lens in box %d: %s => %d\n", $box, $label, $value;
				splice @{ $ar->[$box] }, $i, 1, (join '_', ($label, $value));
			}
			else {
				printf "Remove lens %s from box %d\n", $label, $box;	
				splice @{ $ar->[$box] }, $i, 1;
			}
			return;		
		}
	}
	unless ($op eq '-') {
		printf "Add lens to box %d: %s => %d\n", $box, $label, $value;
		push @{ $ar->[$box] }, join '_', ($label, $value);
	}
	return;
}

sub power {
	my $ar = shift;
	my $power = 0;
	foreach my $box (0..$#boxes) {
		if (defined $ar->[$box]) {
			my @thisbox = @{ $ar->[$box] };
			foreach my $slot (0 .. $#thisbox) {
				my ($l, $v) = split '_', $thisbox[$slot];
				$power += ($box + 1) * ($slot + 1) * $v;
			}
		}
	}
	return $power;
}

sub hash {
	my $v = 0;
	foreach my $c (split //, shift) {
		$v += ord $c;
		$v *= 17;
		$v %= 256;
	}
	return $v;
}