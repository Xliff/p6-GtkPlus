#!/bin/bash

if [ "$1" == "new" ]; then
  rm LastBuildResults*
else
  perl6 scripts/backup_results.pl6
fi
export P6_BUILDING_GTK=1
export NPROC=`perl6 -e '$*KERNEL.cpu-cores.say'`
echo -e "Dependency Generation\n=====================" >> LastBuildResults
/usr/bin/time -p -o LastBuildResults -a perl6 scripts/dependencies.pl6
/usr/bin/time -p /bin/bash -c '(
cat BuildList | xargs -n1 -P'${NPROC}' -I{} ./p6gtkexec --pbuild -e "say q[=== {} ===]; use {};" 2>&1
)' 2>&1 | tee -a LastBuildResults
unset NPROC P6_BUILDING_GTK
cp LastBuildResults stats/LastBuildResults-`date +%Y%m%d`
