use v6.c;

use NativeCall;

use GTK::Compat::Types;

sub g_convert_error_quark ()
  returns GQuark
  is export
  is native(glib)
{ * }

unit package GLib::Raw::Quarks;

our $G_CONVERT_ERROR is export;

# Currently Quark definitions are scattered hither and nether across this code.
# When appropriate, they should be attached to a relevant object, and constant
# define, like the one above.
#
# Compunits like these provide a final destination for those quark definitions
# that do not have a place.

BEGIN {
  $G_CONVERT_ERROR = g_convert_error_quark;
}
