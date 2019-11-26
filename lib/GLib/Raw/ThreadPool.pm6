use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::ThreadPool;

sub g_thread_pool_free (
  GThreadPool $pool,
  gboolean $immediate,
  gboolean $wait
)
  is native(glib)
  is export
{ * }

sub g_thread_pool_get_max_idle_time ()
  returns guint
  is native(glib)
  is export
{ * }

sub g_thread_pool_get_max_threads (GThreadPool $pool)
  returns gint
  is native(glib)
  is export
{ * }

sub g_thread_pool_get_max_unused_threads ()
  returns gint
  is native(glib)
  is export
{ * }

sub g_thread_pool_get_num_threads (GThreadPool $pool)
  returns guint
  is native(glib)
  is export
{ * }

sub g_thread_pool_get_num_unused_threads ()
  returns guint
  is native(glib)
  is export
{ * }

sub g_thread_pool_move_to_front (GThreadPool $pool, gpointer $data)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_thread_pool_new (
  &func (Pointer, Pointer),
  gpointer $user_data,
  gint $max_threads,
  gboolean $exclusive,
  CArray[Pointer[GError]] $error
)
  returns GThreadPool
  is native(glib)
  is export
{ * }

sub g_thread_pool_push (
  GThreadPool $pool,
  gpointer $data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_thread_pool_set_max_idle_time (guint $interval)
  is native(glib)
  is export
{ * }

sub g_thread_pool_set_max_threads (
  GThreadPool $pool,
  gint $max_threads,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_thread_pool_set_max_unused_threads (gint $max_threads)
  is native(glib)
  is export
{ * }

sub g_thread_pool_set_sort_function (
  GThreadPool $pool,
  &func (Pointer, Pointer --> gint),
  gpointer $user_data
)
  is native(glib)
  is export
{ * }

sub g_thread_pool_stop_unused_threads ()
  is native(glib)
  is export
{ * }

sub g_thread_pool_unprocessed (GThreadPool $pool)
  returns guint
  is native(glib)
  is export
{ * }
