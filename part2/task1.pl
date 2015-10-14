use strict;
use warnings;
use diagnostics;
use feature "say";
use Switch;

sub calculate {
    my ( $balance, @expression ) = ( 0, @{ shift @_ } );

    for ( my $i = $#expression; $i >= 0; --$i ) {
        my $current = $expression[$i];

        ++$balance if ( $current eq '(' );
        --$balance if ( $current eq ')' );

        if ( $balance == 0 and ( $current eq '-' or $current eq '+' ) and $i != 0 and $expression[$i - 1] ne 'e' and $expression[$i - 1] ne '(' and $expression[$i - 1] ne '*' and $expression[$i - 1] ne '/' and $expression[$i - 1] ne '+' and $expression[$i - 1] ne '-') {
            my @left = @expression[0..$i-1];
            my @right = @expression[$i+1..$#expression];
            switch ( $current ) {
                case '-' { return calculate( \@left ) - calculate( \@right ) }
                case '+' { return calculate( \@left ) + calculate( \@right ) }
            }
        }
    }

    for ( my $i = $#expression; $i >= 0; --$i ) {
        my $current = $expression[$i];

        ++$balance if ( $current eq '(' );
        --$balance if ( $current eq ')' );

        if ( $balance == 0 and ( $current eq '/' or $current eq '*' ) ) {
            my @left = @expression[0..$i-1];
            my @right = @expression[$i+1..$#expression];
            switch ( $current ) {
                case '/' { return calculate( \@left ) / calculate( \@right ) }
                case '*' { return calculate( \@left ) * calculate( \@right ) }
            }
        }
    }

    for ( my $i = $#expression; $i >= 0; --$i ) {
        my $current = $expression[$i];

        ++$balance if ( $current eq '(' );
        --$balance if ( $current eq ')' );

        if ( $balance == 0 and $current eq '^' ) {
            my @left = @expression[0..$i-1];
            my @right = @expression[$i+1..$#expression];
            switch ( $current ) {
                case '^' { return calculate( \@left ) ** calculate( \@right ) }
            }
        }
    }

    if ( $expression[0] eq '(' and $expression[$#expression] eq ')' ) {
        @expression = @expression[1..$#expression-1];
        return calculate( \@expression );
    }
    
    return join("", @expression);
}

sub evaluate {
    chomp( my $expression = join("", split / /, shift) );
    my @expression_array = split //, $expression;
    return calculate( \@expression_array );
}

while ( <> ) {
    my $expression = $_;
    my $result = evaluate $expression;
    $expression =~ s/\^/**/g;
    my $answer = eval $expression;
    say join(" ", $result, $answer);
}
