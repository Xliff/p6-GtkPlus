use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GTK::Compat::Roles::Object;

class GIO::SocketAddressEnumerator {
  also does GTK::Compat::Roles::Object;

  has GSocketAddressEnumerator $!se;

  submethod BUILD (:$enumerator) {
    $!se = $enumerator;

    self.roleInit-Object;
  }

  method new (GSocketAddressEnumerator $enumerator) {
    self.bless( :$enumerator );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &g_socket_address_enumerator_get_type,
      $n,
      $t
    );
  }

  method next (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False;
  ) {
    clear_error;
    my $sa = g_socket_address_enumerator_next($!se, $cancellable, $error);
    set_error($error);
    $raw ?? $sa !! ::('GIO::SocketAddress').new($sa);
  }

  method next_async (
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    g_socket_address_enumerator_next_async(
      $!se,
      $cancellable,
      $callback,
      $user_data
    );

  }

  method next_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    clear_error;
    my $sa = g_socket_address_enumerator_next_finish($!se, $result, $error);
    set_error($error);
    $raw ?? $sa !! ::('GIO::SocketAddress').new($sa);
  }

}

sub g_socket_address_enumerator_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_socket_address_enumerator_next (
  GSocketAddressEnumerator $enumerator,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GSocketAddress
  is native(gio)
  is export
{ * }

sub g_socket_address_enumerator_next_async (
  GSocketAddressEnumerator $enumerator,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_socket_address_enumerator_next_finish (
  GSocketAddressEnumerator $enumerator,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GSocketAddress
  is native(gio)
  is export
{ * }
