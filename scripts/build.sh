#!/bin/bash
perl6 scripts/backup_results.pl6
echo -e "Dependency Generation\n=====================" >> LastBuildResults
/usr/bin/time -p -o LastBuildResults -a perl6 scripts/dependencies.pl6
if [ "$?" -ne "0" ]; then
  exit
fi

ln=1
if [ "$1" == "--start-at" ]; then
  shift
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    echo "Searching for $1"
    ln=`awk "/$1/{ print NR; exit }" BuildList`
  else
    echo "Starting at $1"
    ln=$1
  fi
  shift
  tail --lines=+$ln BuildList > BuildList.now
else
  cp BuildList BuildList.now
fi

/usr/bin/time -p /bin/bash -c '(
  '"i=$ln"'; n=`wc -l BuildList | cut -f1 -d\ `; for a in `cat BuildList.now`; do
    (
    	echo " === $a === ($i/$n)"
	    ./p6gtkexec -e "use $a" 2>&1
    )
    i=$((i+1))
  done;
  echo;
)' 2>&1 | tee -a LastBuildResults
cp LastBuildResults stats/LastBuildResults-`date --utc +%Y%m%d`
rm BuildList.now
