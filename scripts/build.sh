#!/bin/bash
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
if [ "$1" == "--log" ]; then
  shift
  name=$1
  shift
else
  name='LastBuildResults'
fi

perl6 scripts/backup_results.pl6 $name



/usr/bin/time -p /bin/bash -c '(
  echo "Build started for: ";
  ./p6gtkexec -v;
  '"i=$ln"'; n=`wc -l BuildList | cut -f1 -d\ `; for a in `cat BuildList.now`; do
    (
    	echo " === $a === ($i/$n)"
	    ./p6gtkexec -e "use $a" 2>&1
    )
    i=$((i+1))
  done;
  echo;
)' 2>&1 | tee -a $name
cp $name stats/$name-`date --utc +%Y%m%d`
rm BuildList.now
