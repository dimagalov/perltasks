package Local::Iterator::File;

use strict;
use warnings;

=encoding utf8
=head1 NAME
Local::Iterator::File - file-based iterator
=head1 SYNOPSIS
    my $iterator1 = Local::Iterator::File->new(file => '/tmp/file');
    open(my $fh, '<', '/tmp/file2');
    my $iterator2 = Local::Iterator::File->new(fh => $fh);
=cut


sub new {
	my ( $class, %params ) = @_;

	$params{it} = 0;
	$params{end} = 0;
	open( $params{fh}, "<", $params{filename} ) if ( defined $params{filename} );

	return bless \%params, $class;
}


sub all {
	my ( $class ) = @_;

	my $fh = $class->{fh};
	my @result;
	while ( <$fh> ) {
		chomp $_;
		push @result, $_;
	}

	return \@result;
}


sub next {
	my ( $class ) = @_;

	my $fh = $class->{fh};
	my $line = <$fh>;
	return ( undef, 1 ) if ( !$line );
	chomp( $line );

	return ( $line, 0 );
}

179;
