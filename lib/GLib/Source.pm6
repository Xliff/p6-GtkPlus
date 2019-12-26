use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GTK::Compat::Raw::Main;

use GTK::Raw::Utils;

use GTK::Compat::MainContext;

class GLib::Source {
  has GSource $!gs is implementor;

  submethod BUILD (GSource :$source, Int() :$attach = False) {
    self.setSource($source, :$attach) if $source;
  }

  method setSource(GSource $source, :$attach = False) {
    $!gs = $source;
  }

  method GTK::Compat::Types::GSource
    is also<GSource>
  { $!gs }


  method new (
    GSourceFuncs $source_funcs,
    Int() $struct_size = GSourceFuncs.size-of
  ) {
    my guint $ss = resolve-uint($struct_size);
    self.bless( source => g_source_new($source_funcs, $ss) );
  }

  method add_child_source (GSource() $child_source)
    is also<add-child-source>
  {
    g_source_add_child_source($!gs, $child_source);
  }

  method add_poll (GPollFD $fd) is also<add-poll> {
    g_source_add_poll($!gs, $fd);
  }

  method add_unix_fd (Int() $fd, Int() $events) is also<add-unix-fd> {
    my gint $f = resolve-int($fd);
    my guint $e = resolve-uint($events);
    g_source_add_unix_fd($!gs, $fd, $e);
  }

  method attach (GMainContext() $context = GMainContext) {
    g_source_attach($!gs, $context);
  }

  method destroy {
    g_source_destroy($!gs);
  }

  method get_context is also<get-context> {
    GTK::Compat::MainContext.new( g_source_get_context($!gs) );
  }

  method get_id is also<get-id> {
    g_source_get_id($!gs);
  }

  method get_time is also<get-time> {
    g_source_get_time($!gs);
  }

  method is_destroyed is also<is-destroyed> {
    g_source_is_destroyed($!gs);
  }

  method modify_unix_fd (gpointer $tag, Int() $new_events)
    is also<modify-unix-fd>
  {
    my guint $ne = resolve-uint($new_events);
    g_source_modify_unix_fd($!gs, $tag, $ne);
  }

  method query_unix_fd (gpointer $tag) is also<query-unix-fd> {
    GIOCondition( g_source_query_unix_fd($!gs, $tag) );
  }

  method ref {
    g_source_ref($!gs);
  }

  method remove_child_source (&child_source) is also<remove-child-source> {
    g_source_remove_child_source($!gs, &child_source);
  }

  method remove_poll (GPollFD $fd) is also<remove-poll> {
    g_source_remove_poll($!gs, $fd);
  }

  method remove_unix_fd (gpointer $tag) is also<remove-unix-fd> {
    g_source_remove_unix_fd($!gs, $tag);
  }

  method set_callback (
    &func,
    gpointer       $data   = gpointer,
    GDestroyNotify $notify = gpointer
  )
    is also<set-callback>
  {
    g_source_set_callback($!gs, &func, $data, $notify);
  }

  method set_callback_indirect (
    gpointer $callback_data,
    GSourceCallbackFuncs $callback_funcs
  )
    is also<set-callback-indirect>
  {
    g_source_set_callback_indirect($!gs, $callback_data, $callback_funcs);
  }

  method set_funcs (GSourceFuncs $funcs) is also<set-funcs> {
    g_source_set_funcs($!gs, $funcs);
  }

  method set_name_by_id (Str() $name) is also<set-name-by-id> {
    g_source_set_name_by_id($!gs, $name);
  }

  method unref {
    g_source_unref($!gs);
  }

  method remove (GLib::Source:U: Int() $tag) {
    my guint $t = resolve-uint($tag);

    g_source_remove($t);
  }

  method remove_by_funcs_user_data (
    GLib::Source:U:
    GSourceFuncs $funcs, gpointer $user_data
  )
    is also<remove-by-funcs-user-data>
  {
    g_source_remove_by_funcs_user_data($funcs, $user_data);
  }

  method remove_by_user_data (
    GLib::Source:U:
    gpointer $user_data
  )
    is also<remove-by-user-data>
  {
    g_source_remove_by_user_data($user_data);
  }

  method idle_add (
    GLib::Source:U:
    &function,
    gpointer $data = gpointer
  )
    is also<idle-add>
  {
    g_idle_add(&function, $data);
  }

  method idle_add_full (
    GLib::Source:U:
    Int() $priority,
    &function,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = gpointer
  )
    is also<idle-add-full>
  {
    g_idle_add_full($priority, &function, $data, $notify);
  }

  method idle_remove_by_data (
    GLib::Source:U:
    gpointer $data
  )
    is also<idle-remove-by-data>
  {
    g_idle_remove_by_data($data);
  }

}
