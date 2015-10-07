#!/usr/bin/env perl -nlaF':'

$row += 1; $column = 1; for ( @F ) { if ( $_ > 10 ) { print "Row: $row | Column: $column | Value: $_" }; $column += 1 }
