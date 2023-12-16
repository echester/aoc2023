#!/usr/bin/perl
# aoc2023-14
#
# "
# I woke up at 05:11 and thought, YES!
# "
 
use v5.10;
use strict;
use Data::Dumper;

my @field;
my %memo;
my %res;
while(<>) {
	chomp;
	next unless length;
	push @field, $_;
}

my $load = 0;
my $ncyc = 1000000000;
my $lastload = 0;
my $sig;
for (my $cycle=0; $cycle<$ncyc; $cycle++) {

	# north
	@field = transpose(\@field);
	@field = tilt(\@field);
	@field = transpose(\@field);

	# west
	@field = rotright(\@field);
	@field = transpose(\@field);
	@field = tilt(\@field);
	@field = transpose(\@field);

	# south
	@field = rotright(\@field);	
	@field = transpose(\@field);
	@field = tilt(\@field);
	@field = transpose(\@field);

	# east
	@field = rotright(\@field);
	@field = transpose(\@field);
	@field = tilt(\@field);
	@field = transpose(\@field);

	# back to north for next cycle
	@field = rotright(\@field);
	
	$sig = sig(\@field);
	# last if (exists $memo{$sig});

	$res{$sig} = calcload(\@field);
	last if (exists $memo{$sig});
	$memo{$sig}++;
}
	
	say $res{$sig};
	exit;

sub tilt {
	my $ar = shift;
	my @f = @$ar;
	foreach my $r (@f) {
		$r .= '#';
		my $s = 0;
		my $i = index($r, '#');
		while ($i >= 0) {
			substr($r, $i, 1) = "!";
			substr($r, $s, $i-$s) = strsort(substr($r, $s, $i-$s));
			$s = $i+1;
			$i = index($r, '#');
		};
	chop $r;
	$r =~ s/\!/\#/g;
	}
	return @f;
}

sub calcload {
	my $ar = shift;
	my @f = @$ar;
	@f = transpose(\@f);
	my $load = 0;
	foreach my $r (@f) {
		for (my $x=0; $x <= length($r); $x++) {
			if (substr($r, $x, 1) eq 'O') {
				my $temp = length ($r) - $x;
				$load += $temp;
			}
		}
	}
	return $load;	
}

sub transpose {
	# transpose a matrix represented as an 1-d array of strings
	my $ar = shift;
	my @tm = ();
	foreach my $r (@$ar) {
		my @c = split //, $r;
		$tm[$_] .= $c[$_] foreach (0..$#c);
	}
	return @tm;
}

sub rotright {
	# rotate a matrix represented as an 1-d array of strings clockwise
	my $ar = shift;
	my @tm = ();
	foreach my $r (@$ar) {
		my @c = split //, $r;
		$tm[$_] = $c[$_] . $tm[$_] foreach (0..$#c);
	}
	return @tm;
}

sub strsort {
	return join '', reverse sort split //, shift;
}

sub sig {
	my $ar = shift;
	my @arr = @$ar;
	my $sig = join '', @arr;
}