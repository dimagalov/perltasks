package Local::Iterator::Concater;

use strict;
use warnings;

=encoding utf8
=head1 NAME
Local::Iterator::Concater - concater of other iterators
=head1 SYNOPSIS
    my $iterator = Local::Iterator::Concater->new(
        iterators => [
            $another_iterator1,
            $another_iterator2,
        ],
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

	return ( undef, 1 ) if ( ($class->{it} >= scalar @{ $class->{iterators} }) );
	my $iterator = $class->{iterators}->[$class->{it}];
	my ( $next, $end ) = $iterator->next;
	if ( $end ) {
		$class->{it} += 1;
		return $class->next();
	}

	return ( $next, $end ); 
}

179;
