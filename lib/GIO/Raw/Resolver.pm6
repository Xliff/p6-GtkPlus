use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::Resolver;

sub g_resolver_error_quark ()
  returns GQuark
  is native(gio)
  is export
{ * }

sub g_resolver_free_addresses (GList $addresses)
  is native(gio)
  is export
{ * }

sub g_resolver_free_targets (GList $targets)
  is native(gio)
  is export
{ * }

sub g_resolver_get_default ()
  returns GResolver
  is native(gio)
  is export
{ * }

sub g_resolver_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_by_address (
  GResolver $resolver,
  GInetAddress $address,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_by_address_async (
  GResolver $resolver,
  GInetAddress $address,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_by_address_finish (
  GResolver $resolver,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_by_name (
  GResolver $resolver,
  Str $hostname,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_by_name_async (
  GResolver $resolver,
  Str $hostname,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_by_name_finish (
  GResolver $resolver,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_by_name_with_flags (
  GResolver $resolver,
  Str $hostname,
  GResolverNameLookupFlags $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_by_name_with_flags_async (
  GResolver $resolver,
  Str $hostname,
  GResolverNameLookupFlags $flags,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_by_name_with_flags_finish (
  GResolver $resolver,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_records (
  GResolver $resolver,
  Str $rrname,
  GResolverRecordType $record_type,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_records_async (
  GResolver $resolver,
  Str $rrname,
  GResolverRecordType $record_type,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_records_finish (
  GResolver $resolver,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_service (
  GResolver $resolver,
  Str $service,
  Str $protocol,
  Str $domain,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_service_async (
  GResolver $resolver,
  Str $service,
  Str $protocol,
  Str $domain,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_resolver_lookup_service_finish (
  GResolver $resolver,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gio)
  is export
{ * }

sub g_resolver_set_default (GResolver $resolver)
  is native(gio)
  is export
{ * }
