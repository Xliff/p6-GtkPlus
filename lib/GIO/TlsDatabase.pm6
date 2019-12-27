use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GIO::Raw::TlsDatabase;

use GTK::Compat::Roles::Object;

use GIO::TlsCertificate;

class GIO::TlsDatabase {
  also does GTK::Compat::Roles::Object;

  has GTlsDatabase $!td is implementor;

  submethod BUILD (:$tls-database) {
    $!td = $tls-database;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GTlsDatabase
    is also<GTlsDatabase>
  { $!td }

  method new (GTlsDatabase $tls-database) {
    self.bless( :$tls-database );
  }

  method create_certificate_handle (GTlsCertificate $certificate)
    is also<create-certificate-handle>
  {
    g_tls_database_create_certificate_handle($!td, $certificate);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_tls_database_get_type, $n, $t );
  }

  method lookup_certificate_for_handle (
    Str() $handle,
    GTlsInteraction() $interaction,
    Int() $flags,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<lookup-certificate-for-handle>
  {
    my GTlsDatabaseLookupFlags $f = $flags;

    clear_error;
    my $rv = g_tls_database_lookup_certificate_for_handle(
      $!td,
      $handle,
      $interaction,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method lookup_certificate_for_handle_async (|)
      is also<lookup-certificate-for-handle-async>
  { * }

  multi method lookup_certificate_for_handle_async (
    Str() $handle,
    GTlsInteraction() $interaction,
    Int() $flags,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith(
      $handle,
      $interaction,
      $flags,
      GCancellable,
      $callback,
      $user_data
    );
  }
  multi method lookup_certificate_for_handle_async (
    Str() $handle,
    GTlsInteraction() $interaction,
    Int() $flags,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GTlsDatabaseLookupFlags $f = $flags;

    g_tls_database_lookup_certificate_for_handle_async(
      $!td,
      $handle,
      $interaction,
      $flags,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method lookup_certificate_for_handle_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<lookup-certificate-for-handle-finish>
  {
    clear_error;
    my $rv = g_tls_database_lookup_certificate_for_handle_finish(
      $!td,
      $result,
      $error
    );
    set_error($error);
    $rv;
  }

  method lookup_certificate_issuer (
    GTlsCertificate() $certificate,
    GTlsInteraction() $interaction,
    Int() $flags,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<lookup-certificate-issuer>
  {
    my GTlsDatabaseLookupFlags $f = $flags;

    clear_error;
    my $rv = g_tls_database_lookup_certificate_issuer(
      $!td,
      $certificate,
      $interaction,
      $f,
      $cancellable,
      $error
    );
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::TlsCertificate.new($rv) )
      !!
      Nil;
  }

  proto method lookup_certificate_issuer_async (|)
      is also<lookup-certificate-issuer-async>
  { * }

  multi method lookup_certificate_issuer_async (
    GTlsCertificate() $certificate,
    GTlsInteraction() $interaction,
    Int() $flags,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith(
      $certificate,
      $interaction,
      $flags,
      GCancellable,
      $callback,
      $user_data
    );
  }
  multi method lookup_certificate_issuer_async (
    GTlsCertificate() $certificate,
    GTlsInteraction() $interaction,
    Int() $flags,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GTlsDatabaseLookupFlags $f = $flags;

    g_tls_database_lookup_certificate_issuer_async(
      $!td,
      $certificate,
      $interaction,
      $f,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method lookup_certificate_issuer_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<lookup-certificate-issuer-finish>
  {
    clear_error;
    my $rv = g_tls_database_lookup_certificate_issuer_finish(
      $!td,
      $result,
      $error
    );
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::TlsCertificate.new($rv) )
      !!
      Nil;
  }

  method lookup_certificates_issued_by (
    GByteArray() $issuer_raw_dn,
    GTlsInteraction() $interaction,
    Int() $flags,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$glist = False,
    :$raw = False
  )
    is also<lookup-certificates-issued-by>
  {
    my GTlsDatabaseLookupFlags $f = $flags;

    clear_error;
    my $rv = g_tls_database_lookup_certificates_issued_by(
      $!td,
      $issuer_raw_dn,
      $interaction,
      $f,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;
    return $rv if     $glist;

    $rv = GLib::GList.new($rv)
      but GLib::Roles::ListData[GTlsCertificate];

    $raw ?? $rv.Array !! $rv.Array.map({ GIO::TlsCertificate.new($_) })
  }

  proto method lookup_certificates_issued_by_async (|)
      is also<lookup-certificates-issued-by-async>
  { * }

  multi method lookup_certificates_issued_by_async (
    GByteArray() $issuer_raw_dn,
    GTlsInteraction() $interaction,
    Int() $flags,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith(
      $issuer_raw_dn,
      $interaction,
      $flags,
      GCancellable,
      $callback,
      $user_data
    );
  }
  multi method lookup_certificates_issued_by_async (
    GByteArray() $issuer_raw_dn,
    GTlsInteraction() $interaction,
    Int() $flags,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GTlsDatabaseLookupFlags $f = $flags;

    g_tls_database_lookup_certificates_issued_by_async(
      $!td,
      $issuer_raw_dn,
      $interaction,
      $f,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method lookup_certificates_issued_by_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$glist = False,
    :$raw = False
  )
    is also<lookup-certificates-issued-by-finish>
  {
    clear_error;
    my $rv = g_tls_database_lookup_certificates_issued_by_finish(
      $!td,
      $result,
      $error
    );
    set_error($error);

    return Nil unless $rv;
    return $rv if     $glist;

    $rv = GLib::GList.new($rv)
      but GLib::Roles::ListData[GTlsCertificate];

    $raw ?? $rv.Array !! $rv.Array.map({ GIO::TlsCertificate.new($_) })
  }

  method verify_chain (
    GTlsCertificate() $chain,
    Str() $purpose,
    GSocketConnectable() $identity,
    GTlsInteraction() $interaction,
    Int() $flags,
    GCancellable $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<verify-chain>
  {
    my GTlsDatabaseVerifyFlags $f = $flags;

    GTlsCertificateFlagsEnum(
      g_tls_database_verify_chain(
        $!td,
        $chain,
        $purpose,
        $identity,
        $interaction,
        $f,
        $cancellable,
        $error
      )
    );
  }

  proto method verify_chain_async (|)
      is also<verify-chain-async>
  { * }

  multi method verify_chain_async (
    GTlsCertificate() $chain,
    Str() $purpose,
    GSocketConnectable() $identity,
    GTlsInteraction() $interaction,
    Int() $flags,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith(
      $chain,
      $purpose,
      $identity,
      $interaction,
      $flags,
      GCancellable,
      $callback,
      $user_data
    );
  }
  multi method verify_chain_async (
    GTlsCertificate() $chain,
    Str() $purpose,
    GSocketConnectable() $identity,
    GTlsInteraction() $interaction,
    Int() $flags,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GTlsDatabaseVerifyFlags $f = $flags;

    g_tls_database_verify_chain_async(
      $!td,
      $chain,
      $purpose,
      $identity,
      $interaction,
      $flags,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method verify_chain_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<verify-chain-finish>
  {
    clear_error;
    my $rv = g_tls_database_verify_chain_finish($!td, $result, $error);
    set_error($error);

    GTlsCertificateFlagsEnum($rv);
  }

}
