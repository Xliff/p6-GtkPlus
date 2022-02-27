#!/usr/bin/env raku

use GTK::Raw::Enums;

sub MAIN ($enum, $strip) {
  my \enum-type = ::($enum);

  say "when \"{ .[1] }\" \{ { .[0] } \}"
    for enum-type.enums.pairs
                       .map({ [
                          .key, .key.subst($strip, '', :g)
                                    .lc
                                    .subst("_", "-", :g)
                        ] });
}
{
