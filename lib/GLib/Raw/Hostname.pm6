use v6.c;

use GTK::Compat::Types;

unit package GLib::Raw::Hostname;

### /usr/include/glib-2.0/glib/ghostutils.h

sub g_hostname_is_ascii_encoded (Str $hostname)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_hostname_is_ip_address (Str $hostname)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_hostname_is_non_ascii (Str $hostname)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_hostname_to_ascii (Str $hostname)
  returns Str
  is native(glib)
  is export
{ * }

sub g_hostname_to_unicode (Str $hostname)
  returns Str
  is native(glib)
  is export
{ * }
