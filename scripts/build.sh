#!/bin/bash

echo -e "Dependency Generation\n=====================" >> LastBuildResults
/usr/bin/time -p -o LastBuildResults -a perl6 scripts/dependencies.pl6
if [ "$?" -ne "0" ]; then
  exit
fi

if [ "$1" == "--start-at" ]; then
  shift
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    echo "Searching for $1"
    ln=`awk '/$1/{ print NR; exit }' BuildList`
  else
    echo "Starting at $1"
    ln=$1
  fi
  shift
  tail --lines=+$ln BuildList > BuildList.now
else
  cp BuildList BuildList.now
fi
if [ "$1" == "--new" ]; then
  shift
  rm LastBuildResults*
else
  perl6 scripts/backup_results.pl6
fi
/usr/bin/time -p /bin/bash -c '(
  for a in `cat BuildList.now`; do
    (
    	echo " === $a ==="
	./p6gtkexec -e "use $a" 2>&1
    )
  done;
  echo;
)' 2>&1 | tee -a LastBuildResults
cp LastBuildResults stats/LastBuildResults-`date +%Y%m%d`
rm BuildList.now
