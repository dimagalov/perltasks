package Local::PerlCourse::JSONL;

use JSON;

use strict;
use warnings;
use diagnostics;
use feature "say";

use Exporter 'import';
our @EXPORT_OK = qw(encode_jsonl decode_jsonl);

=encoding utf8

=head1 NAME

Local::PerlCourse::JSONL - JSON-lines encoder/decoder

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS

    use Local::PerlCourse::JSONL qw(
        encode_jsonl
        decode_jsonl
    );

    $string = encode_jsonl([
        {a => 1},
        {b => 2},
    ]);

    $array_ref = decode_jsonl(
        '{"a": 1}' + "\n" +
        '{"b": 2}'
    );

=cut

sub encode_jsonl {
    my $encoded;
    my @input_lines = @{$_[0]};
    for my $current_line( @input_lines ) {
        $encoded .= JSON::to_json( $current_line )."\n";
    }
    chomp( $encoded );
    return $encoded;
}

sub decode_jsonl {
    my @decoded;
    my $input_line = $_[0];
    for my $current_line( split("\n", $input_line) ) {
        push( @decoded, JSON::from_json($current_line) );
    }
    return \@decoded;
}

179;
