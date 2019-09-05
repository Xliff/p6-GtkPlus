use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GLib::Raw::Quark;

class GLib::Quark {

  method new (|) {
    die 'GLib::Quark is static and does not require instantiation.'
      if $DEBUG;

    GLib::Quark;
  }

  method from_static_string (Str() $string) is also<from-static-string> {
    g_quark_from_static_string($string);
  }

  method from_string (Str() $string) is also<from-string> {
    g_quark_from_string($string);
  }

  method intern_static_string (Str() $string) is also<intern-static-string> {
    g_intern_static_string($string);
  }

  method intern_string (Str() $string) is also<intern-string> {
    g_intern_string($string);
  }

  method to_string (Int() $quark) is also<to-string> {
    my GQuark $q = $quark;

    g_quark_to_string();
  }

  method try_string (Str() $string) is also<try-string> {
    g_quark_try_string($string);
  }

}
