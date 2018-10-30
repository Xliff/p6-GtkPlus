#!/bin/bash

rm MROList
time (
  for a in `cat BuildList`; do
    c="use GTK::Widget; use $a; if $a.does(GTK::Widget) { print '$a' ~ ' => '; say $a.^mro.perl ~ ','; }"
    echo $c;
    perl6 -Ilib -e "$c" >> MROList
  done
)
