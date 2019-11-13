use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;

role GIO::Roles::ActionMap {
  has GActionMap $!actmap;

  method GTK::Compat::Types::GActionMap
    is also<GActionMap>
  { $!actmap }

  method roleInit-ActionMap {
    $!actmap = cast(
      GActionMap,
      self.^attributes(:local)[0].get_value(self)
    );
  }

  method add_action (GAction() $action)
    is also<add-action>
  {
    g_action_map_add_action($!actmap, $action);
  }

  proto method add_action_entries (|)
    is also<add-action-entries>
  { * }

  multi method add_action_entries (
    @entries,
    gpointer $user_data = Pointer
  ) {
    @entries .= map({
      do {
        when GActionEntry                { $_ }
        when .^can('GActionEntry').elems { .GActionEntry }
        default {
          die '@entries should only consist of GActionEntry compatible objects'
        }
      }
    });
    my $lb = GTK::Compat::Roles::TypedBuffer.new(@entries);

    samewith($lb.p, @entries.elems, $user_data);
  }
  multi method add_action_entries (
    Pointer $entries,              # BLOCK of GActionEntry structs
    Int() $n_entries,
    gpointer $user_data = Pointer
  ) {
    my gint $n = resolve-int($n_entries);

    g_action_map_add_action_entries($!actmap, $entries, $n, $user_data);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_action_map_get_type, $n, $t );
  }

  method lookup_action (Str() $action_name) is also<lookup-action> {
    self.new( g_action_map_lookup_action($!actmap, $action_name) );
  }

  method remove_action (Str() $action_name) is also<remove-action> {
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
  Pointer $entries,                   # BLOCK of GActionEntry
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
