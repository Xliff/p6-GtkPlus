use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GLib::Roles::StaticClass;

class GLib::UUID {
  also does GLib::Roles::StaticClass;

  method string_is_valid (Str $str) {
    g_uuid_string_is_valid($str);
  }

  method string_random {
    g_uuid_string_random();
  }
}


### /usr/include/glib-2.0/glib/guuid.h

sub g_uuid_string_is_valid (Str $str)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_uuid_string_random ()
  returns Str
  is native(glib)
  is export
{ * }
