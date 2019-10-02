use v6.c;

use GIO::Raw::Subs;

unit package GIO::Raw::Quarks;

our $G_IO_ERROR is export;

sub unstable_get_quark($name, &sub, $n is rw, $t is rw) {
  return $t if ($n // 0) > 0;
  repeat {
    $t = &sub();
    die "Could not get stable result for an { $name }"
      if $n++ > 20;
  } until $t == &sub();
  $t;
}

BEGIN {
  state ($n, $t);

  $G_IO_ERROR = unstable_get_quark(
    'Error Quark', &g_io_error_quark, $n, $t
  );
}
