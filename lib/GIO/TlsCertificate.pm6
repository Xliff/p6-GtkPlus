use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GIO::Raw::TlsCertificate;

use GLib::ByteArray;
use GLib::Value;
use GLib::GList;

use GLib::Roles::ListData;
use GTK::Roles::Properties;

class GIO::TlsCertificate {
  also does GTK::Roles::Properties;

  has GTlsCertificate $!c is implementor;

  submethod BUILD (:$tls) {
    $!c = $tls;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GTlsCertificate
    is also<GTlsCertificate>
  { $!c }

  method new (GTlsCertificate $tls) {
    $tls ?? self.bless( :$tls ) !! Nil;
  }

  method new_from_file (Str() $file, CArray[Pointer[GError]] $error = gerror)
    is also<new-from-file>
  {
    clear_error;
    my $tls = g_tls_certificate_new_from_file($file, $error);
    set_error($error);

    $tls ?? self.bless( :$tls ) !! Nil;
  }

  method new_from_files (
    Str() $cert_file,
    Str() $key_file,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-from-files>
  {
    clear_error;
    my $tls = g_tls_certificate_new_from_files($cert_file, $key_file, $error);
    set_error($error);

    $tls ?? self.bless( :$tls ) !! Nil;
  }

  method new_from_pem (
    Blob() $data,
    Int() $length,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-from-pem>
  {
    my gssize $l = $length;

    clear_error;
    my $tls = g_tls_certificate_new_from_pem($data, $length, $error);
    set_error($error);

    $tls ?? self.bless( :$tls ) !! Nil;
  }

  method list_new_from_file (
    GIO::TlsCertificate:U:
    Str() $file,
    CArray[Pointer[GError]] $error = gerror,
    :$glist = False, :$raw = False
  )
    is also<list-new-from-file>
  {
    my $la = g_tls_certificate_list_new_from_file($file, $error);

    return $la if     $glist;
    return Nil unless $la;

    $la = GLib::GList.new($la)
      but GLib::Roles::ListData[GTlsCertificate];

    $raw ?? $la.Array !! $la.Array.map({ GIO::TlsCertificate.new($_) });
  }

  # Type: GByteArray
  method certificate (:$raw = False) is rw  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('certificate', $gv)
        );

        my $c = $gv.object;
        $c ??
          ( $raw ?? $c !! GTK::Compat::ByteArray.new($c) )
          !!
          Nil
      },
      STORE => -> $, GByteArray() $val is copy {
        $gv.object = $val;
        self.prop_set('certificate', $gv);
      }
    );
  }

  # Type: gchar
  method certificate-pem is rw  is also<certificate_pem> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('certificate-pem', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('certificate-pem', $gv);
      }
    );
  }

  # Type: GTlsCertificate
  method issuer (:$raw = False) is rw  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ { self.get_issuer(:$raw) },
      STORE => -> $, GTlsCertificate() $val is copy {
        $gv.object = $val;
        self.prop_set('issuer', $gv);
      }
    );
  }

  # Type: GByteArray
  method private-key is rw  is also<private_key> {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        warn 'private-key does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GByteArray() $val is copy {
        $gv.object = $val;
        self.prop_set('private-key', $gv);
      }
    );
  }

  # Type: gchar
  method private-key-pem is rw  is also<private_key_pem> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        warn 'private-key-pem does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('private-key-pem', $gv);
      }
    );
  }

  method get_issuer (:$raw = False) is also<get-issuer> {
    my $i = g_tls_certificate_get_issuer($!c);

    $i ??
      ($raw ?? $i !! GIO::TlsCertificate.new($i) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_tls_certificate_get_type, $n, $t );
  }

  proto method is_same (|)
      is also<is-same>
  { * }

  multi method is_same (GTlsCertificate() $cert_two) {
    GIO::TlsCertificate.is_same($!c, $cert_two);
  }
  multi method is_same (
    GIO::TlsCertificate:U:
    GTlsCertificate() $cert_one,
    GTlsCertificate() $cert_two
  ) {
    so g_tls_certificate_is_same($cert_one, $cert_two);
  }

  method verify (
    GSocketConnectable() $identity,
    GTlsCertificate() $trusted_ca
  ) {
    GTlsCertificateFlagsEnum(
      g_tls_certificate_verify($!c, $identity, $trusted_ca)
    );
  }

}
