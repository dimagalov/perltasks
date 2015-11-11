package Local::PerlCourse::Currency;

use strict;
use warnings;
use diagnostics;
use feature "say";

use Exporter 'import';
our @EXPORT_OK = qw(set_rate);

=encoding utf8

=head1 NAME

Local::PerlCourse::Currency - currency converter

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS

    use Local::PerlCourse::Currency qw(set_rate);
    set_rate(
        usd => 1,
        rur => 65.44,
        eur => 1.2,
        # ...
    );

    my $rur = Local::PerlCourse::Currency::usd_to_rur(42);
    my $cny = Local::PerlCourse::Currency::gbp_to_cny(30);

=cut

my %exchange_rates = ();

sub set_rate {
    %exchange_rates = @_;
}

sub AUTOLOAD {
    our $AUTOLOAD;

    my @parsed_function = split('::', $AUTOLOAD);
    my @values = split('_', $parsed_function[scalar(@parsed_function) - 1]);

    die "Currency \"$values[0]\" no specified" if (!exists($exchange_rates{$values[0]}));
    die "Currency \"$values[2]\" no specified" if (!exists($exchange_rates{$values[2]}));

    my $from = $exchange_rates{$values[0]};
    my $to = $exchange_rates{$values[2]};

    return $_[0] * $from / $to;
}

179;
