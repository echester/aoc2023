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
I'm thankful I threw this approach out quickly, because it would have completely failed for part 2. As it was, part 2 took me about 1 minute of thinking and 1 minute of implement/test, because I had stopped thinking about the digits and was just manipulating the strings. The above substitutions remove all the edge cases, then I remove everything that isn't a digit, then only keep the first and last chars, and just accumulate it all. I am pretty algorithmically happy with that approach.

Time for sleep, as I've been up all night testing ranging with NASA Lunar Reconaissance Orbiter for Intuitive Machines. Fun times.

## Day 2 - ?
_" "_

## Day 3 - ?
_" "_

## Day 4 - ?
_" "_

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
