#!/bin/bash

if [ "$1" == "new" ]; then
  rm LastBuildResults*
else
  perl6 scripts/backup_results.pl6
fi
export P6_BUILDING_GTK=1
echo -e "Dependency Generation\n=====================" >> LastBuildResults
/usr/bin/time -p -o LastBuildResults -a perl6 scripts/dependencies.pl6
/usr/bin/time -p /bin/bash -c '(
  for a in `cat BuildList`; do
    (
    	echo " === $a ==="
	perl6 --stagestats \
		-I${P6_GTK_HOME}/p6-Pango/lib \
		-I${P6_GTK_HOME}/p6-GtkPlus/lib \
		-I${P6_GTK_HOME}/p6-WebkitGTK/lib \
		-I${P6_GTK_HOME}/p6-SourceViewGTK/lib \
    -I${P6_GTK_HOME}/p6-AMTK/lib \
    -I${P6_GTK_HOME}/p6-TEPL/lib \
    -I${P6_GTK_HOME}/p6-GooCanvas/lib \
		-e "use $a" 2>&1
    )
  done;
  echo;
)' 2>&1 | tee -a LastBuildResults
unset P6_BUILDING_GTK
