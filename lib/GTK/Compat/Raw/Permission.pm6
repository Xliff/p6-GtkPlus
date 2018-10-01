use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Raw::Permission;

sub g_permission_acquire (
  GPermission $permission,
  GCancellable $cancellable,
  GError $error is rw
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_permission_acquire_async (
  GPermission $permission,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_permission_acquire_finish (
  GPermission $permission,
  GAsyncResult $result,
  GError $error is rw
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_permission_get_allowed (GPermission $permission)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_permission_get_can_acquire (GPermission $permission)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_permission_get_can_release (GPermission $permission)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_permission_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_permission_impl_update (
  GPermission $permission,
  gboolean $allowed,
  gboolean $can_acquire,
  gboolean $can_release
)
  is native(gio)
  is export
  { * }

sub g_permission_release (
  GPermission $permission,
  GCancellable $cancellable,
  GError $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_permission_release_async (
  GPermission $permission,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_permission_release_finish (
  GPermission $permission,
  GAsyncResult $result,
  GError $error
)
  returns uint32
  is native(gio)
  is export
  { * }
