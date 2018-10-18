#!/bin/sh

for a in `cat BuildList`; do echo " === $a ==="; perl6 --stagestats -Ilib -e "use $a"; done
