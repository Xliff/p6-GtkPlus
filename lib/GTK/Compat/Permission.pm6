use v6.c;

use Method::Also;
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

  method GTK::Compat::Types::GPermission is also<Permission> { $!p }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method acquire (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    my GCancellable $c = $cancellable // GCancellable;
    clear_error;
    g_permission_acquire($!p, $c, $error);
    set_error($error);
  }

  method acquire_async  (
    GCancellable $cancellable = GCancellable,
    GAsyncReadyCallback $callback = GAsyncReadyCallback,
    gpointer $user_data = gpointer
  ) 
    is also<acquire-async>
  {
    g_permission_acquire_async($!p, $cancellable, $callback, $user_data);
  }

  method acquire_finish  (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror()
  ) 
    is also<acquire-finish>
  {
    clear_error
    g_permission_acquire_finish($!p, $result, $error);
    set_error($error);
  }

  method get_allowed 
    is also<
      get-allowed
      allowed
    > 
  {
    so g_permission_get_allowed($!p);
  }

  method get_can_acquire 
    is also<
      get-can-acquire
      can_acquire
      can-acquire
    > 
  {
    so g_permission_get_can_acquire($!p);
  }

  method get_can_release 
    is also<
      get-can-release
      can_relase
      can-release
    > 
  {
    so g_permission_get_can_release($!p);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &g_permission_get_type, $n, $t );
  }

  method impl_update (
    Int() $allowed,
    Int() $can_acquire,
    Int() $can_release
  ) 
    is also<impl-update>
  {
    my @b = ($allowed, $can_acquire, $can_release);
    my gboolean ($a, $ca, $cr) = self.RESOLVE-BOOL(@b);
    g_permission_impl_update($!p, $a, $ca, $cr);
  }

  method release (
    GCancellable $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    g_permission_release($!p, $cancellable, $error);
    set_error($error);
  }

  method release_async  (
    GCancellable $cancellable,
    GAsyncReadyCallback $callback = GAsyncReadyCallback,
    gpointer $user_data = gpointer
  ) 
    is also<release-async>
  {
    g_permission_release_async($!p, $cancellable, $callback, $user_data);
  }

  method release_finish (
    GAsyncResult $result, 
    CArray[Pointer[GError]] $error = gerror()
  ) 
    is also<release-finish>
  {
    clear_error;
    g_permission_release_finish($!p, $result, $error);
    set_error($error);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
