use v6.c;

use GIO::Raw::Subs;

unit package GIO::Raw::Quarks;

our $G_IO_ERROR is export;

BEGIN {
  $G_IO_ERROR = g_io_error_quark;
}
