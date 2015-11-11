use strict;
use warnings;

use Test::More tests => 3;

use Local::PerlCourse::Currency qw(set_rate);

set_rate(
    rur  => 1,
    usd  => 60,
    euro => 70,
);

is(Local::PerlCourse::Currency::rur_to_rur(42), 42, 'trivial');
is(Local::PerlCourse::Currency::rur_to_usd(120), 2, 'cheap to expensive');
is(Local::PerlCourse::Currency::euro_to_usd(42), 49, 'expensive to cheap');
