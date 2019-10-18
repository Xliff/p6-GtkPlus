use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GIO::Raw::TlsPassword;

use GTK::Compat::Roles::Object;

class GIO::TlsPassword {
  also does GTK::Compat::Roles::Object;

  has GTlsPassword $!tp;

  submethod BUILD (:$tls-password) {
    $!tp = $tls-password;

    self.roleInit-Object;
  }

  multi method new (GTlsPassword $tls-password) {
    self.bless( :$tls-password );
  }
  multi method new (Int() $flags, Str() $description) {
    my GTlsPasswordFlags $f = $flags;

    self.bless( tls-password => g_tls_password_new($f, $description) )
  }

  method GTK::Compat::Types::GTlsPassword
    is also<GTlsPassword>
  { $!tp }

  method description is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_tls_password_get_description($!tp);
      },
      STORE => sub ($, $description is copy) {
        g_tls_password_set_description($!tp, $description);
      }
    );
  }

  method flags is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTlsPasswordFlagsEnum( g_tls_password_get_flags($!tp) );
      },
      STORE => sub ($, Int() $flags is copy) {
        my GTlsPasswordFlags $f = $flags;

        g_tls_password_set_flags($!tp, $f);
      }
    );
  }

  method warning is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_tls_password_get_warning($!tp);
      },
      STORE => sub ($, Str() $warning is copy) {
        g_tls_password_set_warning($!tp, $warning);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_tls_password_get_type, $n, $t );
  }

  method get_value (gsize $length) is also<get-value> {
    my gsize $l = $length;

    g_tls_password_get_value($!tp, $l);
  }

  method set_value (Str() $value, Int() $length) is also<set-value> {
    my gsize $l = $length;

    g_tls_password_set_value($!tp, $value, $l);
  }

  method set_value_full (
    Str $value,
    Int() $length,
    GDestroyNotify $destroy = gpointer
  ) is also<set-value-full> {
    my gsize $l = $length;

    g_tls_password_set_value_full($!tp, $value, $l, $destroy);
  }

}
