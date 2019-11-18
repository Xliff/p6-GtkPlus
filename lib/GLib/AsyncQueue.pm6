use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GLib::Raw::AsyncQueue;

class GLib::AsyncQueue {
  has GAsyncQueue $!aq is implementor;

  submethod BUILD (:$queue) {
    $!aq = $queue;
  }

  method GTK::Compat::Types::GAsyncQueue
    is also<GAsyncQueue>
  { $!aq }

  method new {
    self.bless( queue => g_async_queue_new() );
  }

  method new_full (GDestroyNotify $item_free_func) is also<new-full> {
    g_async_queue_new_full($item_free_func);
  }

  method length {
    g_async_queue_length($!aq);
  }

  method length_unlocked is also<length-unlocked> {
    g_async_queue_length_unlocked($!aq);
  }

  method lock {
    g_async_queue_lock($!aq);
  }

  method pop {
    g_async_queue_pop($!aq);
  }

  method pop_unlocked is also<pop-unlocked> {
    g_async_queue_pop_unlocked($!aq);
  }

  method push (gpointer $data) {
    g_async_queue_push($!aq, $data);
  }

  method push_front (gpointer $item) is also<push-front> {
    g_async_queue_push_front($!aq, $item);
  }

  method push_front_unlocked (gpointer $item) is also<push-front-unlocked> {
    g_async_queue_push_front_unlocked($!aq, $item);
  }

  method push_sorted (
    gpointer $data,
    GCompareDataFunc $func,
    gpointer $user_data = gpointer
  )
    is also<push-sorted>
  {
    g_async_queue_push_sorted($!aq, $data, $func, $user_data);
  }

  method push_sorted_unlocked (
    gpointer $data,
    GCompareDataFunc $func,
    gpointer $user_data = gpointer
  )
    is also<push-sorted-unlocked>
  {
    g_async_queue_push_sorted_unlocked($!aq, $data, $func, $user_data);
  }

  method push_unlocked (gpointer $data) is also<push-unlocked> {
    g_async_queue_push_unlocked($!aq, $data);
  }

  method ref {
    g_async_queue_ref($!aq);
  }

  method remove (gpointer $item) {
    g_async_queue_remove($!aq, $item);
  }

  method remove_unlocked (gpointer $item) is also<remove-unlocked> {
    g_async_queue_remove_unlocked($!aq, $item);
  }

  method sort (GCompareDataFunc $func, gpointer $user_data = gpointer) {
    g_async_queue_sort($!aq, $func, $user_data);
  }

  method sort_unlocked (
    gpointer $data,
    GCompareDataFunc $func,
    gpointer $user_data = gpointer
  )
    is also<sort-unlocked>
  {
    g_async_queue_sort_unlocked($!aq, $func, $user_data);
  }

  method timeout_pop (Int() $timeout) is also<timeout-pop> {
    my guint64 $t = $timeout;

    g_async_queue_timeout_pop($!aq, $t);
  }

  method timeout_pop_unlocked (Int() $timeout) is also<timeout-pop-unlocked> {
    my guint64 $t = $timeout;

    g_async_queue_timeout_pop_unlocked($!aq, $t);
  }

  method try_pop is also<try-pop> {
    g_async_queue_try_pop($!aq);
  }

  method try_pop_unlocked is also<try-pop-unlocked> {
    g_async_queue_try_pop_unlocked($!aq);
  }

  method unlock {
    g_async_queue_unlock($!aq);
  }

  method unref {
    g_async_queue_unref($!aq);
  }
}
