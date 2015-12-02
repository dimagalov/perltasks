package Local::Iterator::Array;

use strict;
use warnings;

=encoding utf8
=head1 NAME
Local::Iterator::Array - array-based iterator
=head1 SYNOPSIS
    my $iterator = Local::Iterator::Array->new(array => [1, 2, 3]);
=cut


sub new {
	my ( $class, %params ) = @_;

	$params{it} = 0;

	return bless \%params, $class;
}


sub all {
	my ( $class ) = @_;

	my @result = @{ $class->{array} }[ $class->{it}..(scalar @{ $class->{array} } - 1) ];
	$class->{it} = scalar @{ $class->{array} };

	return \@result;
}


sub next {
	my ( $class ) = @_;

	return ( undef, 1 ) if ( ($class->{it} >= scalar @{$class->{array}}) );
	$class->{it} += 1;

	return ( $class->{array}[$class->{it} - 1], 0 ); 
}

179;
