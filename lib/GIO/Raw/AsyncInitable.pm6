use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::AsyncInitable;

sub g_async_initable_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_async_initable_init_async (
  GAsyncInitable $initable,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_async_initable_init_finish (
  GAsyncInitable $initable,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_async_initable_new_finish (
  GAsyncInitable $initable,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GObject
  is native(gio)
  is export
{ * }

sub g_async_initable_newv_async (
  GType                $object_type,
  guint                $n_parameters,
  GParameter           $parameters,
  gint                 $io_priority,
  GCancellable         $cancellable,
  GAsyncReadyCallback  $callback,
  gpointer             $user_data
)
  is DEPRECATED<g_object_new_with_properties() and g_async_initable_init_async()>
  is native(gio)
  is export
{ * }
