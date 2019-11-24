use v6.c;

use GTK::Compat::Types;

use GLib::Raw::Hostname;

use GLib::Roles::StaticClass;

class GLib::Hostname {
  also does GLib::Roles::StaticClass;

  method is_ascii_encoded (Str() $hostname) {
    so g_hostname_is_ascii_encoded($hostname);
  }

  method is_ip_address (Str() $hostname) {
    so g_hostname_is_ip_address($hostname);
  }

  method is_non_ascii (Str() $hostname) {
    so g_hostname_is_non_ascii($hostname);
  }

  method to_ascii (Str() $hostname) {
    g_hostname_to_ascii($hostname);
  }

  method to_unicode (Str() $hostname) {
    g_hostname_to_unicode($hostname);
  }

}
