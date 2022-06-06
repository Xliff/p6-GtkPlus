#!/usr/bin/env raku
use v6.c;

use Method::Also;

sub MAIN ($class) {
  my \C = try require ::($class);

  my @method-names = C.^methods(:local).grep({ .rw && $_ !~~ AliasedMethod })
                                       .map( *.name )
                                       .sort;

  my $max-method-name-size = @method-names.map( *.chars ).max;

  for @method-names {
    my ($under_name, $dashed-name) = .contains('-')
      ?? ( .subst('-', '_', :g), $_ )
      !! ( .contains('_') ?? ( $_, .subst('_', '-', :g) )
                          !! ( $_, Nil) );
    print $under_name.fmt("%-{ $max-method-name-size}s");
    print "\t$dashed-name" if $dashed-name;
    print "\n";
  }
}
