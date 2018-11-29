#!/bin/bash

perl6 scripts/dependencies.pl6
if [ "$1" == "new" ]; then
  rm LastBuildResults*
else
  perl6 scripts/backup_results.pl6
fi
time (
  for a in `cat BuildList`; do
    (echo " === $a ==="; perl6 --stagestats -Ilib -e "use $a" 2>&1)
  done
) 2>&1 | tee -a LastBuildResults
