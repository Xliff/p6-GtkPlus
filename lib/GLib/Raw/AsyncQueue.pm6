use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::AsyncQueue;

sub g_async_queue_length (GAsyncQueue $queue)
  returns gint
  is native(glib)
  is export
{ * }

sub g_async_queue_length_unlocked (GAsyncQueue $queue)
  returns gint
  is native(glib)
  is export
{ * }

sub g_async_queue_lock (GAsyncQueue $queue)
  is native(glib)
  is export
{ * }

sub g_async_queue_new ()
  returns GAsyncQueue
  is native(glib)
  is export
{ * }

sub g_async_queue_new_full (GDestroyNotify $item_free_func)
  returns GAsyncQueue
  is native(glib)
  is export
{ * }

sub g_async_queue_pop (GAsyncQueue $queue)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_async_queue_pop_unlocked (GAsyncQueue $queue)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_async_queue_push (GAsyncQueue $queue, gpointer $data)
  is native(glib)
  is export
{ * }

sub g_async_queue_push_front (GAsyncQueue $queue, gpointer $item)
  is native(glib)
  is export
{ * }

sub g_async_queue_push_front_unlocked (GAsyncQueue $queue, gpointer $item)
  is native(glib)
  is export
{ * }

sub g_async_queue_push_sorted (
  GAsyncQueue $queue,
  gpointer $data,
  GCompareDataFunc $func,
  gpointer $user_data
)
  is native(glib)
  is export
{ * }

sub g_async_queue_push_sorted_unlocked (
  GAsyncQueue $queue,
  gpointer $data,
  GCompareDataFunc $func,
  gpointer $user_data
)
  is native(glib)
  is export
{ * }

sub g_async_queue_push_unlocked (GAsyncQueue $queue, gpointer $data)
  is native(glib)
  is export
{ * }

sub g_async_queue_ref (GAsyncQueue $queue)
  returns GAsyncQueue
  is native(glib)
  is export
{ * }

sub g_async_queue_remove (GAsyncQueue $queue, gpointer $item)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_async_queue_remove_unlocked (GAsyncQueue $queue, gpointer $item)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_async_queue_sort (
  GAsyncQueue $queue,
  GCompareDataFunc $func,
  gpointer $user_data
)
  is native(glib)
  is export
{ * }

sub g_async_queue_sort_unlocked (
  GAsyncQueue $queue,
  GCompareDataFunc $func,
  gpointer $user_data
)
  is native(glib)
  is export
{ * }

sub g_async_queue_timeout_pop (GAsyncQueue $queue, guint64 $timeout)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_async_queue_timeout_pop_unlocked (GAsyncQueue $queue, guint64 $timeout)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_async_queue_try_pop (GAsyncQueue $queue)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_async_queue_try_pop_unlocked (GAsyncQueue $queue)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_async_queue_unlock (GAsyncQueue $queue)
  is native(glib)
  is export
{ * }

sub g_async_queue_unref (GAsyncQueue $queue)
  is native(glib)
  is export
{ * }
