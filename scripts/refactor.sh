#!/bin/sh

# Should also exclude $1, but that's not really required.
filelist=`find . \
  \( \
    -name examples \
    -o \
    -name .touch \
    -o \
    -name scripts \
    -o \
    -name t \
  \) \
  -prune \
  -type f \
  -o \
  -type f \
  -name \*.pm6 \
`

for a in $filelist; do
  echo $a
  mv $a $a.ref-bak
  sed -e "s/$1/$2/" $a.ref-bak > $a
done
