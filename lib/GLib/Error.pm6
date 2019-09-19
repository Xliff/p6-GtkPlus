use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GLib::Raw::Error;

use GTK::Compat::Roles::TypedBuffer;

class GLib::Error {
  has GError $!e handles;

  submethod BUILD (:$error) {
    $!e = $error;
  }

  method GTK::Compat::Types::GError
    is also<GError>
  { $!e }

  multi method new (GError $error) {
    self.bless( :$error );
  }
  multi method new (*@a) {
    GError.new(|@a);
  }

  method new_literal (GQuark() $domain, Int() $code, Str() $message)
    is also<new-literal>
  {
    my gint $c = $code;

    self.bless( error => g_error_new_literal($domain, $c, $message) );
  }

  method copy {
    GLib::Error.new( g_error_copy($!e) );
  }

  method free {
    g_error_free($!e);
  }

  method clear {
    my $eb = GTK::Compat::Roles::TypedBuffer[GError].new( size => 1 );
    $ea.bind(0, $!e);

    my $ea = CArray[Pointer[GError]].new;
    $ea[0] = $eb.p;

    g_clear_error($eb);
  }

  # Not sure of a valid use-case for this.
  #
  # method propagate_error (GError() $src) {
  #   my $eb = GTK::Compat::Roles::TypedBuffer[GError].new( size => 1 );
  #   $ea.bind(0, GError);
  #
  #   my $ea = CArray[Pointer[GError]].new;
  #   $ea[0] = $eb.p;
  #
  #   g_propagate_error($ea, $src);
  #   $!e = $ea[0];
  #   Nil;
  # }

  method set_error_literal (GQuark $domain, Int() $code, Str() $message)
    is also<set-error-literal>
  {
    # g_set_error_literal($!e, $domain, $code, $message);
    my gint $c = $code;
    self.free;
    $!e = GError.new($domain, $c, $message);
  }

  method matches (GQuark $domain, Int() $code) {
    my gint $c = $code;

    so g_error_matches($!e, $domain, $code);
  }

}
