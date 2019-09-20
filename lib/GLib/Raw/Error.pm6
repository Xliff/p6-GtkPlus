use v6.c;

use NativeCall;

use GTK::Compat::Types;

sub g_error_copy (GError $error)
  returns GError
  is native(glib)
  is export
{ * }

# sub g_error_free (GError $error)
#   is native(glib)
#   is export
# { * }

sub g_clear_error (CArray[Pointer[GError]] $err)
  is native(glib)
  is export
{ * }

sub g_propagate_error (CArray[Pointer[GError]] $dest, GError $src)
  is native(glib)
  is export
{ * }

sub g_set_error_literal (
  CArray[Pointer[GError]] $err,
  GQuark $domain,
  gint $code,
  Str $message
)
  is native(glib)
  is export
{ * }

sub g_error_matches (GError $error, GQuark $domain, gint $code)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_error_new_literal (GQuark $domain, gint $code, Str $message)
  returns GError
  is native(glib)
  is export
{ * }
