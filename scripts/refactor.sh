#!/bin/sh

filelist=`find . \
  \( \
    -wholename lib/GLib/Variant.pm6 \
    -o \
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
echo $filelist;
exit;
for a in $filelist; do echo $a; mv $a $a.ref-bak; sed -e 's/GTK::Compat::Variant/GLib::Variant/' $a.ref-bak > $a; done
