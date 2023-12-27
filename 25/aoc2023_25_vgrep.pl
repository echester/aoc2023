#!/usr/bin/perl
# aoc2023-25-vgrep
#
# "
# plotting the graph, manually removing links, then counting the subgraphs
# seems to be a completely valid approach. is it elegant? no. 
# satisfying? also no. did i try to do this purely programmatically? 
# yes, and i believe the approach is sound but i'm not waiting around for 
# the answer.
# "
 
use v5.10;
use strict;
use warnings;
use Graph;

my %comps;

say "graph day25 {";

while(<>) {
	chomp;
	/(\w+):\s*(.*)/;
	my $node = $1;
	my @net = split / /, $2;
	my @prev = (exists $comps{$node}) ? $comps{$node} -> @* : ();
	foreach my $c (@net) {
		appendarinha(\%comps, $node, $c);
		appendarinha(\%comps, $c, $node);
	}
	$comps{$node} = [@prev];
	printf "%s -- {%s}\n", $node, $2;
}
say "}";

print "dump graph data into <file>; use sfdp -Tsvg <file> >full.svg to plot; \n";
print "then remove required edges at lines 38-40.\n";
removeedge(\%comps, 'zkt', 'jhq');
removeedge(\%comps, 'lnr', 'pgt');
removeedge(\%comps, 'vph', 'tjz');

countGraphs(\%comps); 
exit;

sub countGraphs {
	my $href = shift;
	my %data = %$href;
	my $g = Graph->new(undirected => 1);
	for my $src ( keys %data ) {
    	for my $tgt ( @{ $data{$src} } ) { $g->add_edge($src, $tgt); }
	}
	my @subgraphs = $g->connected_components;
	my @allgraphs;
	for my $subgraph ( @subgraphs ) {
	    push @allgraphs, {};
	    for my $node ( @$subgraph ) {
	        if ( exists $data{ $node } ) {
	            $allgraphs[-1]{$node} = [ @{ $data{$node} } ];
	        }
	    }
	}
	printf "%d groups\n", scalar @subgraphs;
	foreach (@subgraphs) { printf "size  = %d\n", scalar $_->@*; }	
}

sub removeedge {
	my ($ref, $n1, $n2) = @_;
	foreach my $k (keys %comps) {
		if ($k eq $n1) {
			my @p = ${$ref}{$k} -> @*;
			@p = grep { $_ ne $n2 } @p;
			${$ref}{$k} = [@p]
		}
		elsif ($k eq $n2) {
			my @p = ${$ref}{$k} -> @*;
			@p = grep { $_ ne $n1 } @p;
			${$ref}{$k} = [@p]
		}		
	}
}

sub appendarinha {
	my ($ref, $k, $v) = @_;
	my @p = (exists ${$ref}{$k}) ? ${$ref}{$k} -> @* : ();
	push @p, $v;
	${$ref}{$k} = [@p];
}
