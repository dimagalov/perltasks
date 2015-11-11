package Local::PerlCourse::GetterSetter;

use strict;
use warnings;
use diagnostics;
use feature "say";

no strict 'refs';

=encoding utf8

=head1 NAME

Local::PerlCourse::GetterSetter - getters/setters generator

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS

    package Local::PerlCourse::SomePackage;
    use Local::PerlCourse::GetterSetter qw(x y);

    set_x(50);
    print our $x; # 50

    our $y = 42;
    print get_y(); # 42
    set_y(11);
    print get_y(); # 11

=cut

sub import {
    my $package = caller;
    for my $variable_name (@_[1..$#_]) {

        my $f = "${package}::set_${variable_name}";
        *{$f} = sub {
            return ${"${package}::${variable_name}"} = $_[0];
        };

        $f = "${package}::get_${variable_name}";
        *{$f} = sub {
            return ${"${package}::${variable_name}"};
        };
    }
}

179;