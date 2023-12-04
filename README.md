# aoc2023
A repo for my efforts for AoC 2023. Because I can't not. Argh. 
Here's what its all about: [[aoc2023](https://adventofcode.com)]

## Day 1 - Trebuchet?!

[PERL]

_"It's easy to be enthusiastic at this point."_

This was good fun, because it took me an _age_ to realise that letters were shared between written numbers... note to self to read the examples very carefully. I was worried about having to progressively build strings up from the left to replace only the first digit, but then hit upon a set of substitutions that respects the overlaps:

```
s/one/o1e/g;
s/two/t2o/g;
s/three/t3e/g;
s/four/f4r/g;
s/five/f5e/g;
s/six/s6x/g;
s/seven/s7n/g;
s/eight/e8t/g;
s/nine/n9e/g;
```

Strictly, these aren't all needed since (for example), no numbers begin with 'r' or 'x', but it was cleaner to show the working. 
In part 1, I started out trying to grab the first and last digit with a regex, but that fell over on the test input when there was only a single digit which needed to be captured twice.
I'm thankful I threw this approach out quickly, because it would have completely failed for part 2. 

As it was, part 2 took me about 1 minute of thinking and 1 minute of implement/test, because I had stopped thinking about the digits and was just manipulating the strings. The above substitutions remove all the edge cases, then I remove everything that isn't a digit, then only keep the first and last chars, and just accumulate it all. I am pretty algorithmically happy with that approach.

Time for sleep, as I've been up all night testing ranging with NASA Lunar Reconnaissance Orbiter for Intuitive Machines. Fun times.

## Day 2 - Cube Conundrum

[PERL]

_"Look, I'm telling you now - they're going to use this trebuchet and need to calculate trajectories. It'll miss, and they'll need to know the optimum settings for each target. The answer will be the product of the settings."_ (Prediction written on day 1). 

OK, I was wrong. That prediction was too hard for day 2. Give it time ;)

Today was a good input parsing exercise, then with trivial arithmetic on the values. This felt like a regex solution, because I think everything feels like a regex solution.
I didn't read the problem quite clearly enough first time, and instead of finding out whether the games were possible, i was checking that there were at least enough cubes for the game, which isn't the same deal. Flipped it, and all worked.

Experience from prior years suggested we'd need to keep track of the number of balls in each game for part 2, so I did that already in part 1, which then made part 2 a trivial modification but even so my difference in rank between part 1 and part 2 is much smaller than on day 1 which surprised me.

Enjoy the rest of the day on Snow Island! ;)

## Day 3 - ?
_" "_

## Day 4 - Scratchcards

[PERL]

_"sneaky Eric - made it look like recursion when it isn't."_
Part 1 of this is _so_ easy its the shortest and fastest problem yet, and perfect for perl:

```perl
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
```
... so immediately, before even solving this, one by rights ought to be thinking part 2 is going to be *horrific*. As always, it pays to really read the thing carefully more than once because if you are still focussed on the score, then the whole thing looks like recursion. And really, that's probably a sound way to do it and there are probably funky iterables in python that just do all the hard work for you.

I was happy to realise quickly that the answer required is the number of cards - so we don't actually care what the score is, or which cards contributed to it, nor need to do any reverse look-up kind of thing. For me, the fastest way was to have an array to hold card counts in, and nest some fors() like this:
```
for (_all the cards_) {
	for (_all the numbers on the cards_) {
		if (_this number wins_) {
			for (_each copy of this card_) {
				add copies of subsequent cards!
			}
		}
	}
}
```
I had some print debug in there which made it slow, but I cleaned it up before adding to repo and (shocker) for part 2 I added some explanatory comments.

## Day 5 - ?
_" "_

## Day 6 - ?
_" "_

## Day 7 - ?
_" "_

## Day 8 - ?
_" "_

_Predictive comment: Just creating this repo in mid-November. So - day 8. This is where I guess I will get to before it gets too hard to complete both parts before breakfast and get the kids to school. Let's see how well that stacks up against reality. 3 weeks to go._


## Day 9 - ?
_" "_

## Day 10 - ?
_" "_

## Day 11 - ?
_" "_

## Day 12 - ?
_" "_

## Day 13 - ?
_" "_

## Day 14 - ?
_" "_

## Day 15 - ?
_" "_

## Day 16 - ?
_" "_

## Day 17 - ?
_" "_

## Day 18 - ?
_" "_

## Day 19 - ?
_" "_

## Day 20 - ?
_" "_

## Day 21 - ?
_" "_

## Day 22 - ?
_" "_

## Day 23 - ?
_" "_

## Day 24 - ?
_" "_

## Day 25 - ?
_" "_

Phew. This was all so unnecessary.
