use strict;

my @array;

while ( <> ) {
    chomp;
    my @row = split /:/, $_;
    push @array, \@row;
}

use Data::Dumper; print Dumper( \@array );
