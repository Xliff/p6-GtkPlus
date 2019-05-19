use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Main;

sub g_main_context_acquire (GMainContext $context)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_main_context_add_poll (GMainContext $context, GPollFD $fd, gint $priority)
  is native(glib)
  is export
  { * }

sub g_main_context_check (
  GMainContext $context,
  gint $max_priority,
  Pointer $fds,
  gint $n_fds
)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_main_context_default ()
  returns GMainContext
  is native(glib)
  is export
  { * }

sub g_main_context_dispatch (GMainContext $context)
  is native(glib)
  is export
  { * }

sub g_main_context_find_source_by_funcs_user_data (
  GMainContext $context,
  GSourceFuncs $funcs,
  gpointer $user_data
)
  returns GSource
  is native(glib)
  is export
  { * }

sub g_main_context_find_source_by_id (GMainContext $context, guint $source_id)
  returns GSource
  is native(glib)
  is export
  { * }

sub g_main_context_find_source_by_user_data (
  GMainContext $context,
  gpointer $user_data
)
  returns GSource
  is native(glib)
  is export
  { * }

sub g_main_context_get_poll_func (GMainContext $context)
  returns Pointer
  is native(glib)
  is export
  { * }

sub g_main_context_get_thread_default ()
  returns GMainContext
  is native(glib)
  is export
  { * }

sub g_main_context_invoke (
  GMainContext $context,
  &function (Pointer --> gboolean),
  gpointer $data
)
  is native(glib)
  is export
  { * }

sub g_main_context_invoke_full (
  GMainContext $context,
  gint $priority,
  &function (Pointer --> gboolean),
  gpointer $data,
  GDestroyNotify $notify
)
  is native(glib)
  is export
  { * }

sub g_main_context_is_owner (GMainContext $context)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_main_context_iteration (GMainContext $context, gboolean $may_block)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_main_context_new ()
  returns GMainContext
  is native(glib)
  is export
  { * }

sub g_main_context_pending (GMainContext $context)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_main_context_pop_thread_default (GMainContext $context)
  is native(glib)
  is export
  { * }

sub g_main_context_prepare (GMainContext $context, gint $priority)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_main_context_push_thread_default (GMainContext $context)
  is native(glib)
  is export
  { * }

sub g_main_context_query (
  GMainContext $context,
  gint $max_priority,
  gint $timeout,
  Pointer $fds,
  gint $n_fds
)
  returns gint
  is native(glib)
  is export
  { * }

sub g_main_context_ref (GMainContext $context)
  returns GMainContext
  is native(glib)
  is export
  { * }

sub g_main_context_ref_thread_default ()
  returns GMainContext
  is native(glib)
  is export
  { * }

sub g_main_context_release (GMainContext $context)
  is native(glib)
  is export
  { * }

sub g_main_context_remove_poll (GMainContext $context, GPollFD $fd)
  is native(glib)
  is export
  { * }

sub g_main_context_set_poll_func (
  GMainContext $context,
  &func (Pointer, guint, gint --> gint)
)
  is native(glib)
  is export
  { * }

sub g_main_context_unref (GMainContext $context)
  is native(glib)
  is export
  { * }

sub g_main_context_wakeup (GMainContext $context)
  is native(glib)
  is export
  { * }

sub g_main_current_source ()
  returns GSource
  is native(glib)
  is export
  { * }

sub g_main_depth ()
  returns gint
  is native(glib)
  is export
  { * }

sub g_child_watch_add (
  GPid $pid,
  &func (GPid, gint, gpointer),
  gpointer $data
)
  returns guint
  is native(glib)
  is export
  { * }

sub g_child_watch_add_full (
  gint $priority,
  GPid $pid,
  &func (GPid, gint, gpointer),
  gpointer $data,
  GDestroyNotify $notify
)
  returns guint
  is native(glib)
  is export
  { * }

sub g_child_watch_source_new (GPid $pid)
  returns GSource
  is native(glib)
  is export
  { * }

sub g_clear_handle_id (
  guint $tag_ptr,
  &func (guint)
)
  is native(glib)
  is export
  { * }

sub g_get_current_time (GTimeVal $result)
  is native(glib)
  is export
  { * }

sub g_get_monotonic_time ()
  returns gint64
  is native(glib)
  is export
  { * }

sub g_get_real_time ()
  returns gint64
  is native(glib)
  is export
  { * }

sub g_idle_add (&function (Pointer --> gboolean), gpointer $data)
  returns guint
  is native(glib)
  is export
  { * }

sub g_idle_add_full (
  gint $priority,
  &function (Pointer --> gboolean),
  gpointer $data,
  GDestroyNotify $notify
)
  returns guint
  is native(glib)
  is export
  { * }

sub g_idle_remove_by_data (gpointer $data)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_idle_source_new ()
  returns GSource
  is native(glib)
  is export
  { * }

sub g_source_add_child_source (GSource $source, GSource $child_source)
  is native(glib)
  is export
  { * }

sub g_source_add_poll (GSource $source, GPollFD $fd)
  is native(glib)
  is export
  { * }

sub g_source_add_unix_fd (GSource $source, gint $fd, guint $events)
  returns Pointer
  is native(glib)
  is export
  { * }

sub g_source_attach (GSource $source, GMainContext $context)
  returns guint
  is native(glib)
  is export
  { * }

sub g_source_destroy (GSource $source)
  is native(glib)
  is export
  { * }

sub g_source_get_can_recurse (GSource $source)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_source_get_context (GSource $source)
  returns GMainContext
  is native(glib)
  is export
  { * }

sub g_source_get_id (GSource $source)
  returns guint
  is native(glib)
  is export
  { * }

sub g_source_get_name (GSource $source)
  returns Str
  is native(glib)
  is export
  { * }

sub g_source_get_priority (GSource $source)
  returns gint
  is native(glib)
  is export
  { * }

sub g_source_get_ready_time (GSource $source)
  returns gint64
  is native(glib)
  is export
  { * }

sub g_source_get_time (GSource $source)
  returns gint64
  is native(glib)
  is export
  { * }

sub g_source_is_destroyed (GSource $source)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_source_modify_unix_fd (
  GSource $source,
  gpointer $tag,
  guint $new_events # GIOCondition $new_events
)
  is native(glib)
  is export
  { * }

sub g_source_new (GSourceFuncs $funcs, guint $struct_size)
  returns GSource
  is native(glib)
  is export
  { * }

sub g_source_query_unix_fd (GSource $source, gpointer $tag)
  returns guint # GIOCondition
  is native(glib)
  is export
  { * }

sub g_source_ref (GSource $source)
  returns GSource
  is native(glib)
  is export
  { * }

sub g_source_remove (guint $tag)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_source_remove_by_funcs_user_data (
  GSourceFuncs $funcs,
  gpointer $user_data
)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_source_remove_by_user_data (gpointer $user_data)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_source_remove_child_source (GSource $source, GSource $child_source)
  is native(glib)
  is export
  { * }

sub g_source_remove_poll (GSource $source, GPollFD $fd)
  is native(glib)
  is export
  { * }

sub g_source_remove_unix_fd (GSource $source, gpointer $tag)
  is native(glib)
  is export
  { * }

sub g_source_set_callback (
  GSource $source,
  &function (Pointer --> gboolean),
  gpointer $data,
  GDestroyNotify $notify
)
  is native(glib)
  is export
  { * }

sub g_source_set_callback_indirect (
  GSource $source,
  gpointer $callback_data,
  GSourceCallbackFuncs $callback_funcs
)
  is native(glib)
  is export
  { * }

sub g_source_set_can_recurse (GSource $source, gboolean $can_recurse)
  is native(glib)
  is export
  { * }

sub g_source_set_funcs (GSource $source, GSourceFuncs $funcs)
  is native(glib)
  is export
  { * }

sub g_source_set_name (GSource $source, Str $name)
  is native(glib)
  is export
  { * }

sub g_source_set_name_by_id (guint $tag, Str $name)
  is native(glib)
  is export
  { * }

sub g_source_set_priority (GSource $source, gint $priority)
  is native(glib)
  is export
  { * }

sub g_source_set_ready_time (GSource $source, gint64 $ready_time)
  is native(glib)
  is export
  { * }

sub g_source_unref (GSource $source)
  is native(glib)
  is export
  { * }

sub g_timeout_add (
  guint $interval,
  &function (Pointer --> gboolean),
  gpointer $data
)
  returns guint
  is native(glib)
  is export
  { * }

sub g_timeout_add_full (
  gint $priority,
  guint $interval,
  &function (Pointer --> gboolean),
  gpointer $data,
  GDestroyNotify $notify
)
  returns guint
  is native(glib)
  is export
  { * }

sub g_timeout_add_seconds (
  guint $interval,
  &function (Pointer --> gboolean),
  gpointer $data
)
  returns guint
  is native(glib)
  is export
  { * }

sub g_timeout_add_seconds_full (
  gint $priority,
  guint $interval,
  &function (Pointer --> gboolean),
  gpointer $data,
  GDestroyNotify $notify
)
  returns guint
  is native(glib)
  is export
  { * }

sub g_timeout_source_new (guint $interval)
  returns GSource
  is native(glib)
  is export
  { * }

sub g_timeout_source_new_seconds (guint $interval)
  returns GSource
  is native(glib)
  is export
  { * }

sub g_main_loop_get_context (GMainLoop $loop)
  returns GMainContext
  is native(glib)
  is export
  { * }

sub g_main_loop_is_running (GMainLoop $loop)
  returns uint32
  is native(glib)
  is export
  { * }

sub g_main_loop_new (GMainContext $context, gboolean $is_running)
  returns GMainLoop
  is native(glib)
  is export
  { * }

sub g_main_loop_quit (GMainLoop $loop)
  is native(glib)
  is export
  { * }

sub g_main_loop_ref (GMainLoop $loop)
  returns GMainLoop
  is native(glib)
  is export
  { * }

sub g_main_loop_run (GMainLoop $loop)
  is native(glib)
  is export
  { * }

sub g_main_loop_unref (GMainLoop $loop)
  is native(glib)
  is export
  { * }
