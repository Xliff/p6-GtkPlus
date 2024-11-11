#!/bin/bash
ln=1
exec=`scripts/get-config.pl6 exec`
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
if [ "$1" == "--log" ]; then
  shift
  name=$1
  shift
else
  name='LastBuildResults'
fi

perl6 scripts/backup_results.pl6 $name


/usr/bin/time -p /bin/bash -c '(
  echo "Build started for project `pwd` revision `git rev-parse HEAD` using:"
  ./'$exec' -v;

  set -e;
  '"i=$ln"'; n=`wc -l BuildList | cut -f1 -d\ `; for a in `cat BuildList.now`; do
    (
    	echo " === $a === ($i/$n)";
	    P6_GLIB_COMPILE_PROCESS=1 ./'$exec' -e "use $a" 2>&1
    )
    i=$((i+1))
  done;
  echo;
)' 2>&1 | tee -a $name
cp $name stats/$name-`date --utc +%Y%m%d`
rm BuildList.now
