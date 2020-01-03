use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::Error;

use GLib::Roles::TypedBuffer;

class GIO::DBus::Error {

  method new (|) {
    warn 'GIO::DBus::Error is a static class and does not need instantiation.';

    GIO::DBus::Error;
  }

  method encode_gerror (GError $error) is also<encode-gerror> {
    g_dbus_error_encode_gerror($error);
  }

  method get_remote_error (GError $error) is also<get-remote-error> {
    g_dbus_error_get_remote_error($error);
  }

  method is_remote_error (GError $error) is also<is-remote-error> {
    g_dbus_error_is_remote_error($error);
  }

  method new_for_dbus_error (
    Str() $dbus_error_name,
    Str() $dbus_error_message
  )
    is also<new-for-dbus-error>
  {
    g_dbus_error_new_for_dbus_error($dbus_error_name, $dbus_error_message);
  }

  method quark {
    g_dbus_error_quark();
  }

  method register_error (
    Int() $error_domain,
    Int() $error_code,
    Str() $dbus_error_name
  )
    is also<register-error>
  {
    my GQuark $ed = $error_domain;
    my gint $ec = $error_code;

    g_dbus_error_register_error($ed, $ec, $dbus_error_name);
  }

  method strip_remote_error (GError $error) is also<strip-remote-error> {
    g_dbus_error_strip_remote_error($error);
  }

  method unregister_error (
    Int() $error_domain,
    Int() $error_code,
    Str() $dbus_error_name
  )
    is also<unregister-error>
  {
    my GQuark $ed = $error_domain;
    my gint $ec = $error_code;

    g_dbus_error_unregister_error($ed, $ec, $dbus_error_name);
  }

  proto method set_dbus_error (|)
      is also<set-dbus-error>
  { * }

  multi method set_dbus_error (
    $error is rw,
    Str() $dbus_error_name,
    Str() $dbus_error_message,
    Str() $dbus_error_prefix,
  ) {
    die '$error must be a GError' unless $error ~~ GError;
    my $ce = CArray[Pointer[GError]];
    $ce[0] = $error.p;
    samewith($ce, $dbus_error_name, $dbus_error_prefix, $dbus_error_message);
    $error = $ce[0] if $ce[0].defined;
  }
  multi method set_dbus_error (
    CArray[Pointer[GError]] $error,
    Str() $dbus_error_name,
    Str() $dbus_error_message,
    Str() $dbus_error_prefix
  ) {
    g_dbus_error_set_dbus_error (
      $error,
      $dbus_error_name,
      $dbus_error_message,
      $dbus_error_prefix,
      Str
    );
  }

  proto method register_error_domain (|)
     is also<register-error-domain>
  { * }

  multi method register_error_domain (
    Str $error_domain_quark_name,
    @entries,
  ) {
    my $b = GLib::Roles::TypedBuffer[GDBusErrorEntry].new(@entries);
    samewith($error_domain_quark_name, $b);
  }
  multi method register_error_domain (
    Str $error_domain_quark_name,
    GLib::Roles::TypedBuffer[GDBusErrorEntry] $b
  ) {
    samewith($error_domain_quark_name, $, $b.p,  $b.elems);
  }
  multi register_error_domain (
    Str $error_domain_quark_name,
    $quark_volatile is rw,
    Pointer $entries,               # const GDBusErrorEntry *entries
    Int() $num_entries
  ) {
    my guint $n = $num_entries;
    my gsize $q = 0;

    g_dbus_error_register_error_domain ($error_domain_quark_name, $q, $entries);
    $quark_volatile = $q;
  }

}
