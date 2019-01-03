#!/bin/bash

if [ "$1" == "new" ]; then
  rm LastBuildResults*
else
  perl6 scripts/backup_results.pl6
fi
echo -e "Dependency Generation\n=====================" >> LastBuildResults
/usr/bin/time -p -o LastBuildResults -a perl6 scripts/dependencies.pl6
/usr/bin/time -p /bin/bash -c '(
  for a in `cat BuildList`; do
    (echo " === $a ==="; perl6 --stagestats -I../p6-Pango/lib -Ilib -e "use $a" 2>&1)
  done;
  echo;
)' 2>&1 | tee -a LastBuildResults
