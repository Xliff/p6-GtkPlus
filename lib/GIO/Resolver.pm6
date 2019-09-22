use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::Resolver;

use GTK::Compat::Roles::Object;

use GTK::Roles::Signals::Generic;

class GIO::Resolver {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Signals::Generic;

  has GResolver $!r;

  submethod BUILD (:$resolver) {
    $!r = $resolver;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GResolver
  { $!r }

  method new (GResolver $resolver) {
    self.bless( :$resolver );
  }

  # Is originally:
  # GResolver, gpointer --> void
  method reload {
    self.connect($!r, 'reload');
  }

  method get_default (GIO::Resolver:U: :$raw = False) {
    my $r = g_resolver_get_default();

    $r ??
      ( $raw ?? $r !! GIO::Resolver.new($r) )
      !!
      Nil;
  }

  method error_quark ( GIO::Resolver:U: ) {
    g_resolver_error_quark();
  }

  method free_addresses ( GIO::Resolver:U: GList() $addresses) {
    g_resolver_free_addresses($addresses);
  }

  method free_targets ( GIO::Resolver:U: GList() $targets) {
    g_resolver_free_targets($targets);
  }

  method get_type {
    state ($n, $t);

    g_resolver_get_type();
  }

  method lookup_by_address (
    GInetAddress() $address,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = g_resolver_lookup_by_address($!r, $address, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method lookup_by_address_async (
    GInetAddress() $address,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    g_resolver_lookup_by_address_async(
      $!r,
      $address,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method lookup_by_address_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = g_resolver_lookup_by_address_finish($!r, $result, $error);
    set_error($error);
    $rv;
  }

  method lookup_by_name (
    Str() $hostname,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False;
  ) {
    clear_error;
    my $l = g_resolver_lookup_by_name($!r, $hostname, $cancellable, $error);
    set_error($error);

    $l ??
      ( $raw ?? $l.Array !! $l.Array.map({ GIO::InetAddress.new($_) }) )
      !!
      Nil;
  }

  method lookup_by_name_async (
    Str() $hostname,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    g_resolver_lookup_by_name_async(
      $!r,
      $hostname,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method lookup_by_name_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    clear_error;
    my $l = g_resolver_lookup_by_name_finish($!r, $result, $error);
    set_error($error);

    $l ??
      ( $raw ?? $l.Array !! $l.Array.map({ GIO::InetAddress.new($_) }) )
      !!
      Nil;
  }

  method lookup_by_name_with_flags (
    Str() $hostname,
    Int() $flags,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False;
  ) {
    my GResolverNameLookupFlags $f = $flags;

    clear_error;
    my $l = g_resolver_lookup_by_name_with_flags(
      $!r,
      $hostname,
      $f,
      $cancellable,
      $error
    );
    set_error($error);

    $l ??
      ( $raw ?? $l.Array !! $l.Array.map({ GIO::InetAddress.new($_) }) )
      !!
      Nil;
  }

  method lookup_by_name_with_flags_async (
    Str() $hostname,
    Int() $flags,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GResolverNameLookupFlags $f = $flags;

    g_resolver_lookup_by_name_with_flags_async(
      $!r,
      $hostname,
      $f,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method lookup_by_name_with_flags_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    clear_error;
    my $l = g_resolver_lookup_by_name_with_flags_finish($!r, $result, $error);
    set_error($error);

    $l ??
      ( $raw ?? $l.Array !! $l.Array.map({ GIO::InetAddress.new($_) }) )
      !!
      Nil;
  }

  method lookup_records (
    Str() $rrname,
    Int() $record_type,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    my GResolverRecordType $rt = $record_type;

    clear_error;
    my $l = g_resolver_lookup_records($!r, $rrname, $rt, $cancellable, $error);
    set_error($error);

    $l ??
      ( $raw ?? $l.Array !! $l.Array.map({ GIO::InetAddress.new($_) }) )
      !!
      Nil;
  }

  method lookup_records_async (
    Str $rrname,
    Int() $record_type,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GResolverRecordType $rt = $record_type;

    g_resolver_lookup_records_async(
      $!r,
      $rrname,
      $rt,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method lookup_records_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False;
  ) {
    clear_error;
    my $l = g_resolver_lookup_records_finish($!r, $result, $error);
    set_error($error);

    $l ??
      ( $raw ?? $l.Array !! $l.Array.map({ GIO::InetAddress.new($_) }) )
      !!
      Nil;
  }

  method lookup_service (
    Str() $service,
    Str() $protocol,
    Str() $domain,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    clear_error;
    my $l = g_resolver_lookup_service(
      $!r,
      $service,
      $protocol,
      $domain,
      $cancellable,
      $error
    );
    set_error($error);

    $l ??
      ( $raw ?? $l.Array !! $l.Array.map({ GIO::InetAddress.new($_) }) )
      !!
      Nil;
  }

  method lookup_service_async (
    Str() $service,
    Str() $protocol,
    Str() $domain,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    g_resolver_lookup_service_async(
      $!r,
      $service,
      $protocol,
      $domain,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method lookup_service_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    clear_error;
    my $l = g_resolver_lookup_service_finish($!r, $result, $error);
    set_error($error);

    $l ??
      ( $raw ?? $l.Array !! $l.Array.map({ GIO::InetAddress.new($_) }) )
      !!
      Nil;
  }

  method set_default {
    g_resolver_set_default($!r);
  }

}