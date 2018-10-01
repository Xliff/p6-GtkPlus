use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Permission;

use GTK::Roles::Types;

class GTK::Compat::Permission {
  also does GTK::Roles::Types;

  has GPermission $!p;

  submethod BUILD(:$permission) {
    $!p = $permission;
  }

  method new (GPermission $p?) {
    my $permission = $p // GPermission.new;
    self.bless(:$permission);
  }

  method GTK::Compat::Types::GPermission {
    $!p;
  }
  method permission {
    $!p;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method acquire (
    GCancellable $cancellable,
    GError $error is rw
  ) {
    my GCancellable $c = $cancellable // GCancellable;
    $error //= GError;
    g_permission_acquire($!p, $c, $error);
  }

  method acquire_async (
    GCancellable $cancellable = GCancellable,
    GAsyncReadyCallback $callback = GAsyncReadyCallback,
    gpointer $user_data = gpointer
  ) {
    g_permission_acquire_async($!p, $cancellable, $callback, $user_data);
  }

  method acquire_finish (
    GAsyncResult $result,
    GError $error is rw
  ) {
    $error //= GError;
    g_permission_acquire_finish($!p, $result, $error);
  }

  method get_allowed {
    so g_permission_get_allowed($!p);
  }

  method get_can_acquire {
    so g_permission_get_can_acquire($!p);
  }

  method get_can_release {
    so g_permission_get_can_release($!p);
  }

  method get_type {
    g_permission_get_type();
  }

  method impl_update (
    Int() $allowed,
    Int() $can_acquire,
    Int() $can_release
  ) {
    my @b = ($allowed, $can_acquire, $can_release);
    my gboolean ($a, $ca, $cr) = self.RESOLVE-BOOL(@b);
    g_permission_impl_update($!p, $a, $ca, $cr);
  }

  method release (
    GCancellable $cancellable = GCancellable,
    GError $error = GError
  ) {
    g_permission_release($!p, $cancellable, $error);
  }

  method release_async (
    GCancellable $cancellable,
    GAsyncReadyCallback $callback = GAsyncReadyCallback,
    gpointer $user_data = gpointer
  ) {
    g_permission_release_async($!p, $cancellable, $callback, $user_data);
  }

  method release_finish (GAsyncResult $result, GError $error = GError) {
    g_permission_release_finish($!p, $result, $error);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
