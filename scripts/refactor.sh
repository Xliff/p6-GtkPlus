#!/bin/bash

if [ "$1" == "--clean" ]; then
	find . -name \*.ref-bak -exec rm {} \;
	echo "All refactor backup files have been removed."
	exit 0
fi

# Should also exclude $1, but that's not really required.
for a in pm6 pl6 t; do
  filelist=`find . \
    \( \
      -name examples \
      -o \
      -name .touch \
      -o \
      -name scripts \
    \) \
    -prune \
    -type f \
    -o \
    -type f \
    -name \*.$a
  `

  for b in $filelist; do
    echo $b
    mv $b $b.ref-bak
    sed -e "s/$1/$2/" $b.ref-bak > $b
  done
done
