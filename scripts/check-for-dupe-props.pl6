#!/usr/bin/env perl6

sub MAIN ($f) { 
  my $c = $f.IO.slurp; 
  $c ~~ m:g/"method" \s (<[\w\-]>+) \s* 'is rw' [ \s* 'is also<' (<[\w\-]>+) '>' ]? /; 
  my @a = gather for $/.Array { 
    take .[0].Str; 
    take .[1].Str if .[1].defined 
  }  
  my %h; 
  %h{$_}++ for @a; 
  .key.say for %h.pairs.grep( *.value > 1 ).sort( *.key );
}
