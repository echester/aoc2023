#!/usr/bin/perl
# aoc2023-07
#
# "
# algorithmically a fun time. started of with a hash tracking it all, but simplified things
# back down to a single alphabetic sort. after cleaning it up, commentary added.
# "
 
use v5.10;
use strict;
use warnings;
# an array of hands
my @popeth;
my $part2 = 0;

# a map of possible outcomes to type ranking
my %tr = ('11111'=>1, '1112'=>2, '122'=>3, '113'=>4, '23'=>5, '14'=>6, '5'=>7); 	

while(<>) {
	chomp;
	my ($hand, $bid) = split ' ';
	# replace picture cards and aces with numerical values
	my @cards = intify(split //, $hand);
	# count jokers (added in part 2)
	my $jokers = $hand =~ tr/J//;
	# prepend the type ranking value to the hand so it sorts on this first, then cards
	my $typerank = $tr{cyfri(@cards)};

	# part 2 switch ###
	if ($part2) { 
		if ($jokers == 1) {
			if ($typerank == 1) { $typerank = 2; }
			elsif ($typerank == 2) { $typerank = 4; }
			elsif ($typerank == 3) { $typerank = 5; }
			elsif ($typerank == 4) { $typerank = 6; }
			elsif ($typerank == 6) { $typerank = 7; }
		}
		elsif ($jokers == 2) {
			$typerank += 2;
			if ($typerank == 5) { $typerank += 1; }
			}
		elsif ($jokers == 3) { $typerank += 2; }
		elsif ($jokers == 4) { $typerank = 7; }
	}
	###################

	unshift @cards, $typerank;
	# save the new 'card', which looks something like fgfngq_765
	push @popeth, join('', map(chr(100+$_), @cards)) . '_' . $bid;
}

# sort the cards
@popeth = sort @popeth;

# rattle through them, multiply-accumulating scores as we go
my $total = 0;
for my $r (0..$#popeth) {
	my ($s, $b) = split /_/, $popeth[$r];
	$total += $b*($r+1);
}

say $total;

sub cyfri {
	# calculate the number of instances of each element in the array, return a sorted 
	# bin count of each type (type not important)
	my @a = @_;
	my %c;
	my @cyf;
	$c{$_}++ foreach (@a);
	push @cyf, $c{$_} foreach (keys %c);
	return join '', sort @cyf;
}

sub intify {
	# for every element in an array, replace instances of letters with numbers
	my @a = @_;
	for my $i (0..$#a) {
		$a[$i] =~ s/T/10/g;
		$a[$i] =~ s/K/13/g;
		$a[$i] =~ s/Q/12/g;
		$a[$i] =~ s/J/11/g;			
		if ($part2) {
			$a[$i] =~ s/11/1/g;
		}
		$a[$i] =~ s/A/14/g;		
	}
	return @a;
}
