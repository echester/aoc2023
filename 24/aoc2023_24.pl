#!/usr/bin/perl
# aoc2023-24
#
# "
# Came back to this on dec 28. Knew at the time how to do it, but 
# couldn't get time with computer on xmas eve out in the wilderness;
# read it on my phone. However, this only does part 1. I haven't wrapped
# my noggin around how to do part 2 yet.
# "
 
use v5.10;
use strict;
use warnings;
use Algorithm::Combinatorics qw| combinations |;

my @hailstones;

while(<>) {
	s/ //g;
	push @hailstones, [map {int} split /[,@]/];
}

my @hpairs = combinations(\@hailstones, 2);
my ($xmin, $xmax, $tmax) = (200000000000000, 400000000000000, 1E16);
my $count = 0;

foreach my $hpr (@hpairs) {
	my @x = $hpr->[0];
	my @y = $hpr->[1];
	my ($pax, $pay, $vax, $vay) = ($x[0][0], $x[0][1], $x[0][3], $x[0][4]);
	my ($pbx, $pby, $vbx, $vby) = ($y[0][0], $y[0][1], $y[0][3], $y[0][4]);

	unless (isparallel($vax, $vay, $vbx, $vby)) { 
		my @crash = intersect($pax, $pay, $vax, $vay, $pbx, $pby, $vbx, $vby);
		++$count if (bound($crash[0], $xmin, $xmax) && bound($crash[1], $xmin, $xmax) && bound($crash[2], 0, $tmax));
	}
}

say $count;

sub intersect {
	my ($x1, $y1, $vx1, $vy1, $x2, $y2, $vx2, $vy2) = @_;
	my $s1 = $vy1 / $vx1;
	my $s2 = $vy2 / $vx2;
	my $c1 = -1 * $s1 * $x1 + $y1;
	my $c2 = -1 * $s2 * $x2 + $y2;
	my $xcross = ($c2 - $c1) / ($s1 - $s2);
	my $ycross = $s1 * $xcross + $c1;
	my $t1 = ($xcross - $x1) / $vx1;
	my $t2 = ($xcross - $x2) / $vx2;
	my $t = ($t1 < $t2) ? $t1 : $t2;
	return ($xcross, $ycross, $t);
}

sub bound {
	my ($val, $min, $max) = @_;
	return (($val >= $min) && ($val <= $max));
}

sub isparallel {
	my ($vx1, $vy1, $vx2, $vy2) = @_;
	return 0 == ($vx1*$vy2 - $vy1*$vx2);
}
