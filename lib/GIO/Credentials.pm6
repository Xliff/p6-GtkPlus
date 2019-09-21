use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::Credentials;

use GTK::Compat::Roles::Object;

class GIO::Credentials {
  has GCredentials $!c;

  submethod BUILD (:$credentials) {
    $!c = $credentials;
  }

  method GTK::Compat::Types::GCredentials
    is also<GCredentials>
  { $!c }

  multi method new (GCredentials $credentials) {
    self.bless( :$credentials );
  }
  multi method new {
    self.bless( credentials => g_credentials_new() );
  }

  method get_native (Int() $native_type) is also<get-native> {
    my GCredentialsType $nt = $native_type;

    g_credentials_get_native($!c, $nt);

  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_credentials_get_type, $n, $t );
  }

  method get_unix_pid (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-unix-pid>
  {
    clear_error;
    my $rv = g_credentials_get_unix_pid($!c, $error);
    set_error($error);
    $rv;
  }

  method get_unix_user (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-unix-user>
  {
    clear_error;
    my $rv = g_credentials_get_unix_user($!c, $error);
    set_error($error);
    $rv;
  }

  method is_same_user (
    GCredentials() $other_credentials,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<is-same-user>
  {
    clear_error;
    my $rv = so g_credentials_is_same_user($!c, $other_credentials, $error);
    set_error($error);
    $rv;
  }

  method set_native (Int() $native_type, gpointer $native)
    is also<set-native>
  {
    my GCredentialsType $nt = $native_type;

    g_credentials_set_native($!c, $nt, $native);
  }

  method set_unix_user (
    uid_t $uid,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-unix-user>
  {
    clear_error;
    my $rv = so g_credentials_set_unix_user($!c, $uid, $error);
    set_error($error);
    $rv;
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    g_credentials_to_string($!c);
  }

}
