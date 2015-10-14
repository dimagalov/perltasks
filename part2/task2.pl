use strict;
use warnings;
use diagnostics;
use feature "say";
use Switch;

sub convert {
    my @stack;
    my ( $notation, @expression ) = ( "", @{ shift @_ } );

    for ( my $i = 0; $i <= $#expression; ) {
        my $current = $expression[$i];

        switch ( $current ) {
            case /^\d/ {
                $notation .= $current;
                if ( !($expression[$i + 1] =~ /^\d/) ) {
                    $notation .= " ";
                }
                ++$i;
            }
            case '(' { push @stack, $current; ++$i }
            case ')' {
                while ( $stack[-1] ne '(' ) {
                    $notation .= $stack[-1] . " ";
                    pop @stack;
                }
                ++$i;
                pop @stack;
            }
            case '-' {
                if ( scalar @stack == 0 or $stack[-1] eq '(' ) {
                    push @stack, $current;
                    ++$i;
                }
                else {
                    $notation .= $stack[-1] . " ";
                    pop @stack;   
                }
            }
            case '+' {
                if ( scalar @stack == 0 or $stack[-1] eq '(' ) {
                    push @stack, $current;
                    ++$i;
                }
                else {
                    $notation .= $stack[-1] . " ";
                    pop @stack;   
                }
            }
            case '/' {
                if ( scalar @stack != 0 and ($stack[-1] eq '*' or $stack[-1] eq '/') ) {
                    $notation .= $stack[-1] . " ";
                    pop @stack;
                }
                else {
                    push @stack, $current;
                    ++$i;
                }
            }
            case '*' {
                if ( scalar @stack != 0 and ($stack[-1] eq '*' or $stack[-1] eq '/') ) {
                    $notation .= $stack[-1] . " ";
                    pop @stack;
                }
                else {
                    push @stack, $current;
                    ++$i;
                }
            }
        }
    }

    while ( scalar @stack != 0 )
    {
        $notation .= $stack[-1];
        pop @stack;
    }

    return $notation;
}

sub evaluate {
    chomp( my $expression = join("", split / /, shift) );
    my @expression_array = split //, $expression;
    return convert( \@expression_array );
}


while ( <> ) {
    say evaluate $_;
}
