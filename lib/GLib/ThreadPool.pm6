use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Subs;

use GTK::Compat::Types;

use GLib::Raw::ThreadPool;

class GLib::ThreadPool {
  has GThreadPool $!tp is implementor;

  submethod BUILD (:$threadpool) {
    $!tp = $threadpool;
  }

  method GTK::Compat::Types::GThreadPool
    is also<GThreadPool>
  { $!tp }

  multi method new (
    &func,
    Int() $max_threads,
    Int() $exclusive
  ) {
    samewith(&func, gpointer, $max_threads, $exclusive);
  }
  multi method new (
    &func,
    gpointer $user_data,
    Int() $max_threads,
    Int() $exclusive,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gint $mt = $max_threads;
    my gboolean $e = so $exclusive;

    clear_error;
    my $rc = g_thread_pool_new(&func, $user_data, $mt, $e, $error);
    set_error($error);
    $rc ?? self.bless( threadpool => $rc ) !! Nil;
  }

  method free (Int() $immediate, Int() $wait) {
    my gboolean ($i, $w) = ($immediate, $wait)».so;

    g_thread_pool_free($!tp, $i, $w);
  }

  method get_max_idle_time ( GLib::ThreadPool:U: )
    is also<get-max-idle-time>
  {
    g_thread_pool_get_max_idle_time();
  }

  method get_max_threads is also<get-max-threads> {
    g_thread_pool_get_max_threads($!tp);
  }

  method get_max_unused_threads ( GLib::ThreadPool:U: )
    is also<get-max-unused-threads>
  {
    g_thread_pool_get_max_unused_threads();
  }

  method get_num_threads is also<get-num-threads> {
    g_thread_pool_get_num_threads($!tp);
  }

  method get_num_unused_threads ( GLib::ThreadPool:U: )
    is also<get-num-unused-threads>
  {
    g_thread_pool_get_num_unused_threads();
  }

  method move_to_front (gpointer $data) is also<move-to-front> {
    g_thread_pool_move_to_front($!tp, $data);
  }

  method push (
    gpointer $data,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_thread_pool_push($!tp, $data, $error);
    set_error($error);
    $rc;
  }

  method set_max_idle_time is also<set-max-idle-time> {
    g_thread_pool_set_max_idle_time($!tp);
  }

  method set_max_threads (
    Int() $max_threads,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-max-threads>
  {
    my gint $mt = $max_threads;

    clear_error;
    my $rc = g_thread_pool_set_max_threads($!tp, $mt, $error);
    set_error($error);
    $rc;
  }

  method set_max_unused_threads is also<set-max-unused-threads> {
    g_thread_pool_set_max_unused_threads($!tp);
  }

  method set_sort_function (
    &func,
    gpointer $user_data = gpointer
  )
    is also<set-sort-function>
  {
    g_thread_pool_set_sort_function($!tp, &func, $user_data);
  }

  method stop_unused_threads ( GLib::ThreadPool:U: )
    is also<stop-unused-threads>
  {
    g_thread_pool_stop_unused_threads();
  }

  method unprocessed {
    g_thread_pool_unprocessed($!tp);
  }

}
