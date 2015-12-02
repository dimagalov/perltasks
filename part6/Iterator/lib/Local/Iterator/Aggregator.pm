package Local::Iterator::Aggregator;

use strict;
use warnings;

=encoding utf8
=head1 NAME
Local::Iterator::Aggregator - aggregator of iterator
=head1 SYNOPSIS
    my $iterator = Local::Iterator::Aggregator->new(
        chunk_length => 2,
        iterator => $another_iterator,
    );
=cut


sub new {
	my ( $class, %params ) = @_;

	$params{it} = 0;

	return bless \%params, $class;
}


sub all {
	my ( $class ) = @_;

	my @result;
	my ( $next, $end ) = $class->next();
	while ( !$end ) {
		push @result, $next;
		( $next, $end ) = $class->next();
	}

	return \@result;
}


sub next {
	my ( $class ) = @_;

	my @result;
	my ( $next, $end, $i );
	for $i ( 1..$class->{chunk_length} ) {
		( $next, $end ) = $class->{iterator}->next();
		if ( $end ) {
			$end = 0 if ( $i != 1 );
			last;
		}
		push @result, $next;
	}

	return ( $end == 1 ) ? ( undef, 1 ) : ( \@result, $end ); 
}

179;
