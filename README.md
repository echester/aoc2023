# aoc2023
A repo for my efforts for AoC 2023. Because I can't not. Argh. 
Here's what its all about: [[aoc2023](https://adventofcode.com)]

The _"comments"_ like this for each day are header comments from my code.

## Day 1 - Trebuchet?!

[PERL]

_"It's easy to be enthusiastic at this point."_

This was good fun, because it took me an _age_ to realise that letters were shared between written numbers... note to self to read the examples very carefully. I was worried about having to progressively build strings up from the left to replace only the first digit, but then hit upon a set of substitutions that respects the overlaps:

```perl
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

[PERL]

_" print debug RULEZ "_

Today was a bit of a shocker; I don't expect to get tripped up on part 1 (but I'm fully ready to be tripped up on part 2).
I did it later than usual on a day that had more fun things in it, and it took long to deal with the edge cases.
Comedy moment: to make the parsing easier, I first remove periods `s/\./ /` and then, hilariously, substituted any other symbols by the gear symbol: `s/\D/*/`. So that went well.



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

## Day 6 - Wait For It

[PERL]

_" If it wasn't for this <bOaT RaCe@> i'd have walked off this island today. "_

It looked too easy to be true, but it was true. I don't know why. I'm wondering if perhaps Eric has "plan B" puzzle days that he can activate depending upon the backlash to some insane recursive bigint shenanigans he's wrought upon us.

I started using List::Util and 2 separate subs to get the distance travelled and ways to win, but the whole thing folds down into just a few functional lines. The core of the thing is: 
```perl
for (my $p=0; $p<=$t; $p++) { $w++ if ($p*($t-$p) > $d); }

```

The real shocker was that part 2 was not a grossly non-linear extension: it was just a single line change to run a single race:
```perl
if(0) { s/\s+//g; } # part 2 switch
```

Phew!

## Day 7 - Camel Cards

[PERL]

_"Algorithmically, a fun time was had by all."_

This was a fun challenge. Not trivial, loads of possible approaches, but it quickly became apparent that a multi-level sort was unnecessary. Instead, I map the hand, including the hand type ranking, into a string, then sort it alphabetically. It probably unnecessary if you're prepared to sit and design your own sort operator and wrap it around a spaceship operator (<=> in perl), but really, I cba.

Here's the thing though, wanna see something _gross_? Check out what gave me the part 2 answer most quickly because there were so few cases I coded them all explicitly...

```perl
if ($part2) { # part 2 switch
		if (($jokers == 1) && ($typerank == 1)) { $typerank = 2; }
		elsif (($jokers == 1) && ($typerank == 2)) { $typerank = 4; }
		elsif (($jokers == 1) && ($typerank == 3)) { $typerank = 5; }
		elsif (($jokers == 1) && ($typerank == 4)) { $typerank = 6; }
		elsif (($jokers == 1) && ($typerank == 6)) { $typerank = 7; }
		elsif (($jokers == 2) && ($typerank == 2)) { $typerank = 4; }
		elsif (($jokers == 2) && ($typerank == 3)) { $typerank = 6; }
		elsif (($jokers == 2) && ($typerank == 5)) { $typerank = 7; }
		elsif (($jokers == 3) && ($typerank == 4)) { $typerank = 6; }
		elsif (($jokers == 3) && ($typerank == 5)) { $typerank = 7; }
		elsif (($jokers == 4) && ($typerank == 6)) { $typerank = 7; }
	}
```
That's so disgraceful I still can't quite believe I'm fessing up enough to put it in the readme. Colour me honest.

## Day 8 - Haunted Wasteland

[PERL]

_" urgh. that's all i have to say about that. "_

_Predictive comment: Just creating this repo in mid-November. So - day 8. This is where I guess I will get to before it gets too hard to complete both parts before breakfast and get the kids to school. Let's see how well that stacks up against reality. 3 weeks to go._

Once I understood that Eric lied his socks off about "simultaneously", and that it was sufficient to work out the endgame for each starting point separately then LCM them, it was fine. 

Until I couldn't remember a fast way to do prime factorisation in perl, and also waaaay ran out of time. So I used
[this site](https://www.calculatorsoup.com/calculators/math/lcm.php) instead.

The other comedy was that in my smugness, I forgot to implement "simultaneously" by resetting my move counter every time, so the steps got silly, so the first attempt at their LCM was vaaaaaaassssst. 

But hey, check out part 1, i think its pretty cute.
```perl
while ($yma ne 'ZZZ') {
	$yma = $nodes{$yma}->[index 'LR', $turns[$steps % @turns]];
	$steps++;
}
```
(_yma_ is 'here' in Welsh, in the unlikely event you were wondering.)

## Day 9 - Mirage Maintenance

[PERL]

_"part 2, are you for real? I publicly said on day 6 that that was the only time part 2 would take 8 characters. Here, it took 7. Foiled again. Comments added post-submission (ofc).
"_

I did, briefly, try a subtraction-based approach to part 2, and wrote it out on paper. As soon as I wrote all 3 test records out, it was shockingly obvious that there is nothing needed except to reverse the records. Bonkers. I was expecting a depth-first search or something properly miserable to ruin my weekend, and all I needed was: 

```perl
my @row = (1) ? reverse split / / : split / /;
```

## Day 10 - ?
_" "_

## Day 11 - ?
_" "_

## Day 12 - ?
_" "_

## Day 13 - Point of Incidence

[PERL]

This day wins the award for the maximum number of commented out lines (before clean-up) and the maximum amount of print debug. You should have seen it. It was like a BASIC program from the '80s with PRINT all over it. First part done quickly, then went for lunch after twting that the hamming
distance wasn't enough to solve the problem. By the end of lunch I convinced myself that actually it was enough to solve the problem, for both parts! Tidy. 

Its worth noting that the solution depended upon Eric being very clever, but not evil: a single smudge that introduced 2 new mirrors wouldn't be caught by my solution. 

While I could have sat and coded my own hamming distance function, this elegant little trick was courtesy of the perl monks: XOR the strings!
```perl
sub hamming {
	my $diff = $_[0] ^ $_[1];
	return $diff =~ tr/\0//c;
}
```
During clean up, i realised some functions had poor names. For example, findmirrors() no longer told me where the mirrors were, it returned the total number of rows above a mirror accumulated over all patterns. It was renamed:
```perl
sub findTotalLinesAboveMirrorsInAllPatternsObviously {
	my $ar = shift;
	my @matrix = @$ar;
	my $retval = 0;
	my $maxhd = 0;
	for (my $i=0; $i<$#matrix; $i++) {
		my @ab = (0..$i);
		my @be;
		foreach (@ab) { unshift @be, 1+$i+$_ if $_+$i < $#matrix; }
		# remove excess above
		while (@ab > @be) { shift @ab; }
		# loop over row pairs
		for (my $k=0; $k<=$#be; $k++) {
			# get hd
			my $hd = hamming($matrix[$ab[$k]], $matrix[$be[$k]]);
			# track maximum hd
			if ($maxhd < $hd) { $maxhd = $hd; }
		}
		# if we're in threshold for this row, its got a mirror under it
		$retval += $i + 1 if ($maxhd == $threshold);
		# reset the tracking
		$maxhd = 0;		
	}
	return $retval;
}
```

The other little thing I like in all this is `unshift` to fill an array of lines below a candidate mirror, and using that to `shift` away unneeded rows above the mirror (because we don't care about reflections that fall outside the mapped space).

## Day 14 - Parabolic Reflector Dish

[PERL]

_"I woke up at 05:11 and thought, YES!"_

First part was fast but inelegant. I reused my `transpose()` function from yesterday, and also made a variant of it called `rotright()`, and then used this pair together with a function `tilt()` that only  tilted the rocks to the north. Moving round rocks (O) is an easy alphabetic sort inside string groups split on cubic rocks (#).

## Day 15 - Lens Library

[PERL]


### Part 1
_"This is way too suspiscious. We're screwed."_

Look how noddy this is. This is the kind of thing that drives The Fear Of Part Two into the hearts of all AoC folks.
```perl
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

```

### Part 2
_"Slow and ugly as a maimed tortoise wearing a sketchy wig."_

(but not as bad as feared!)

Yes, it should have been mapped hashes all the way down, like the reindeer said, but i was having some syntax/sigil difficulty in the small hours.

The problem here was figuring out a data structure that was easier than an array of an array of hashes. This might have been the day to switch to python and have a slightly easier time of it using dicts to hold all this stuff, and maybe even define a lens class.

Very ugly code indeed, even after cleanup. Here's the nicer part, the main loop. 
```perl
our @boxes;

while(<>) {
	chomp;
	foreach (split /,/) {
		/^(\w+)([=-])(\d+)?$/;
		process (\@boxes, hash($1), $1, $2, $3);
	}
}

say power(\@boxes);
```

Looks OK, right? Well you should see the horrors that used to live within `addlens()` and `removelens()`. Only, you can't because i tidied up. A bit.

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
