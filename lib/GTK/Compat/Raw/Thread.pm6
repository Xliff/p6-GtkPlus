use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Thread;

sub g_mutex_clear (GMutex $mutex)
  is native(glib)
  is export
{ * }

sub g_cond_broadcast (GCond $cond)
  is native(glib)
  is export
{ * }

sub g_cond_clear (GCond $cond)
  is native(glib)
  is export
{ * }

sub g_cond_init (GCond $cond)
  is native(glib)
  is export
{ * }

sub g_cond_signal (GCond $cond)
  is native(glib)
  is export
{ * }

sub g_cond_wait (GCond $cond, GMutex $mutex)
  is native(glib)
  is export
{ * }

sub g_cond_wait_until (GCond $cond, GMutex $mutex, gint64 $end_time)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_get_num_processors ()
  returns guint
  is native(glib)
  is export
{ * }

sub g_once_impl (GOnce $once, GThreadFunc $func, gpointer $arg)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_private_get (GPrivate $key)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_private_replace (GPrivate $key, gpointer $value)
  is native(glib)
  is export
{ * }

sub g_private_set (GPrivate $key, gpointer $value)
  is native(glib)
  is export
{ * }

sub g_rec_mutex_clear (GRecMutex $rec_mutex)
  is native(glib)
  is export
{ * }

sub g_rec_mutex_init (GRecMutex $rec_mutex)
  is native(glib)
  is export
{ * }

sub g_rec_mutex_lock (GRecMutex $rec_mutex)
  is native(glib)
  is export
{ * }

sub g_rec_mutex_trylock (GRecMutex $rec_mutex)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_rec_mutex_unlock (GRecMutex $rec_mutex)
  is native(glib)
  is export
{ * }

sub g_rw_lock_clear (GRWLock $rw_lock)
  is native(glib)
  is export
{ * }

sub g_rw_lock_init (GRWLock $rw_lock)
  is native(glib)
  is export
{ * }

sub g_rw_lock_reader_lock (GRWLock $rw_lock)
  is native(glib)
  is export
{ * }

sub g_rw_lock_reader_trylock (GRWLock $rw_lock)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_rw_lock_reader_unlock (GRWLock $rw_lock)
  is native(glib)
  is export
{ * }

sub g_rw_lock_writer_lock (GRWLock $rw_lock)
  is native(glib)
  is export
{ * }

sub g_rw_lock_writer_trylock (GRWLock $rw_lock)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_rw_lock_writer_unlock (GRWLock $rw_lock)
  is native(glib)
  is export
{ * }

sub g_thread_error_quark ()
  returns GQuark
  is native(glib)
  is export
{ * }

sub g_thread_exit (gpointer $retval)
  is native(glib)
  is export
{ * }

sub g_thread_join (GThread $thread)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_thread_new (Str $name, GThreadFunc $func, gpointer $data)
  returns GThread
  is native(glib)
  is export
{ * }

sub g_thread_ref (GThread $thread)
  returns GThread
  is native(glib)
  is export
{ * }

sub g_thread_self ()
  returns GThread
  is native(glib)
  is export
{ * }

sub g_thread_try_new (
  Str $name,
  GThreadFunc $func,
  gpointer $data,
  CArray[Pointer[GError]] $error
)
  returns GThread
  is native(glib)
  is export
{ * }

sub g_thread_unref (GThread $thread)
  is native(glib)
  is export
{ * }

sub g_thread_yield ()
  is native(glib)
  is export
{ * }

sub g_mutex_init (GMutex $mutex)
  is native(glib)
  is export
{ * }

sub g_mutex_lock (GMutex $mutex)
  is native(glib)
  is export
{ * }

sub g_mutex_trylock (GMutex $mutex)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_mutex_unlock (GMutex $mutex)
  is native(glib)
  is export
{ * }
