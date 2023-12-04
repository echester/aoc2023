#!/usr/bin/perl
# aoc2023-04-2
#
# "sneaky Eric - made it look like recursion when it isn't.
# treachery!
# probably should add some commentary, so will do so.
# "
 
# pragmas and modules...
# ...it wouldn't be advent of code without List::Util ;)

use Time::HiRes qw( time );
my $start = time();

use strict;
use warnings;
use List::Util qw| sum |;

# array to hold counts of cards in
my @cards;

# loop over input
while(<>) {
	chomp;
	# array to hold winning numbers
	my @wins;
	# parse the input lines
	/^.+:\s*(.+)\|\s*(.+)$/;
	# store the list of winning numbers for this line in the array
	push @wins, split /\s+/, $1;
	# count the first copy of this card as itself
	$cards[$.]++;
	# introduce an offset pointer for copies of cards. dunno why 'r'. deal.
	my $r = 1;
	# loop over the card numbers on this card
	foreach my $n (split /\s+/, $2) {
		# check if this number is a winning number
		if(grep(/^$n$/, @wins)) {
			# if it is, loop over copies of this card
			for (0..$cards[$.]-1) {
				# add a copy of the card at the next offset
				$cards[$.+$r]++;
			}
			# increment the offset
		$r++;
		}
	}
}
# just avoiding a warning on the zeroth card
shift @cards;
# tell me how many cards i've had to deal with
print sum @cards;

printf("\nelapsed: %0.02f s\n", time() - $start);
