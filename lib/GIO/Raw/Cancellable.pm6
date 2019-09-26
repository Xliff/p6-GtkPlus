use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::Cancellable;

sub g_cancellable_cancel (GCancellable $cancellable)
  is native(gio)
  is export
{ * }

sub g_cancellable_connect (
  GCancellable $cancellable,
  &callback (GCancellable, gpointer),
  GCallback $callback,
  gpointer $data,
  GDestroyNotify $data_destroy_func
)
  returns gulong
  is native(gio)
  is export
{ * }

sub g_cancellable_disconnect (GCancellable $cancellable, gulong $handler_id)
  is native(gio)
  is export
{ * }

sub g_cancellable_get_current ()
  returns GCancellable
  is native(gio)
  is export
{ * }

sub g_cancellable_get_fd (GCancellable $cancellable)
  returns gint
  is native(gio)
  is export
{ * }

sub g_cancellable_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_cancellable_is_cancelled (GCancellable $cancellable)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_cancellable_make_pollfd (GCancellable $cancellable, GPollFD $pollfd)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_cancellable_new ()
  returns GCancellable
  is native(gio)
  is export
{ * }

sub g_cancellable_pop_current (GCancellable $cancellable)
  is native(gio)
  is export
{ * }

sub g_cancellable_push_current (GCancellable $cancellable)
  is native(gio)
  is export
{ * }

sub g_cancellable_release_fd (GCancellable $cancellable)
  is native(gio)
  is export
{ * }

sub g_cancellable_reset (GCancellable $cancellable)
  is native(gio)
  is export
{ * }

sub g_cancellable_set_error_if_cancelled (
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_cancellable_source_new (GCancellable $cancellable)
  returns GSource
  is native(gio)
  is export
{ * }
