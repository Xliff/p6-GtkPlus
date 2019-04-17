use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;

role GTK::Compat::Roles::ActionMap {
  has GActionMap $!actmap;

  method add_action (GAction() $action) {
    g_action_map_add_action($!actmap, $action);
  }

  method add_action_entries (
    GActionEntry $entries,              # BLOCK of GActionEntry structs
    Int() $n_entries,
    gpointer $user_data = Pointer
  ) {
    my gint $n = resolve-int($n_entries);
    g_action_map_add_action_entries($!actmap, $entries, $n, $user_data);
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &g_action_map_get_type, $n, $t );
  }

  method lookup_action (Str() $action_name) {
    self.new( g_action_map_lookup_action($!actmap, $action_name) );
  }

  method remove_action (Str() $action_name) {
    g_action_map_remove_action($!actmap, $action_name);
  }

}

sub g_action_map_add_action (
  GActionMap $action_map,
  GAction $action
)
  is native(gio)
  is export
  { * }

sub g_action_map_add_action_entries (
  GActionMap $action_map,
  GActionEntry $entries,
  gint $n_entries,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_action_map_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_action_map_lookup_action (
  GActionMap $action_map,
  Str $action_name
)
  returns GAction
  is native(gio)
  is export
  { * }

sub g_action_map_remove_action (
  GActionMap $action_map,
  Str $action_name
)
  is native(gio)
  is export
  { * }
