package Local::PerlCourse::JSONP;

use strict;
use feature "say";

use utf8;
use Encode qw(decode);

use Exporter 'import';
our @EXPORT_OK = qw(custom_decode_json);

=encoding utf8

=head1 NAME

Local::PerlCourse::JSONP - JSON decoder

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS

    use Local::PerlCourse::JSONP qw(
        custom_decode_json
    );
    
    %decoded = custom_decode_json(
        qq<{"a":[1,2,3]}>,
    );

=cut

my %ESCAPE = (
    '"'  => '"',
    '\\' => '\\',
    '/'  => '/',
    'b'  => "\x08",
    'f'  => "\x0c",
    'n'  => "\x0a",
    'r'  => "\x0d",
    't'  => "\x09",
);

my $spacing = qr/[\x20\x09\x0a\x0d]/x;

sub custom_decode_json {
    local $_ = shift;

    if (!utf8::is_utf8($_)) {
        $_ = decode("utf-8", $_);
    }

    my $valueref;
    $$valueref = decode_value();
}

sub decode_array {
    my @array;

    until (m/\G($spacing)*\]/gc) {

        push @array, decode_value();

        redo if /\G($spacing)*,/gc;
        last if /\G($spacing)*\]/gc;
    }

    return \@array;
}

sub decode_object {
    my %hash;

    until (m/\G($spacing)*\}/gc) {

        /\G($spacing)*"/gc;

        my $key = decode_string();
        /\G($spacing)*:/gc;
        $hash{$key} = decode_value();

        redo if /\G($spacing)*,/gc;
        last if /\G($spacing)*\}/gc;
    }

    return \%hash;
}

sub decode_string {
    my $pos = pos;

    m!\G((?:(?:[^\x00-\x1f\\"]|\\(?:["\\/bfnrt]|u[0-9a-fA-F]{4})){0,32766})*)!gc;
    my $str = $1;

    m/\G"/gc;

    my $buffer = '';
    while ($str =~ /\G([^\\]*)\\(?:([^u])|u(.{4}))/gc) {
        $buffer .= $1 . ($2 ? $ESCAPE{$2} : pack 'U', hex $3);
    }

    return $buffer . substr $str, pos($str), length($str);
}

sub decode_value {
    /\G[\x20\x09\x0a\x0d]*/gc;
    return decode_string() if /\G"/gc;
    return decode_object() if /\G\{/gc;
    return decode_array() if /\G\[/gc;
    return 0 + $1 if /\G([-]?(?:0|[1-9][0-9]*)(?:\.[0-9]*)?(?:[eE][+-]?[0-9]+)?)/gc;
    return 1 if /\Gtrue/gc;
    return 0 if /\Gfalse/gc;
    return undef if /\Gnull/gc;
}

179;
