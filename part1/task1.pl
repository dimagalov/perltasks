#!/usr/bin/env perl -nla

$total += 1; if ( $F[4] >= 1024 * 1024 ) { print "- ".join(" ", @F[8..$#F]); $big += 1 } END { print "Total files: $total | Big files: $big" }
