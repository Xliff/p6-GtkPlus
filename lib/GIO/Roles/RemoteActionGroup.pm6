use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;

use GIO::Roles::ActionGroup;

role GIO::Roles::RemoteActionGroup {
  also does GIO::Roles::ActionGroup;

  has GRemoteActionGroup $!rag;

  method GTK::Compat::Types::GRemoteActionGroup
    is also<GRemoteActionGroup>
  { $!rag }

  method roleInit-RemoteActionGroup is also<roleInit_RemoteActionGroup> {
    $!rag = cast(
      GRemoteActionGroup,
      self.^attributes(:local)[0].get_value(self)
    );
  }

  method activate_action_full (
    Str() $action_name,
    GVariant() $parameter,
    GVariant() $platform_data
  )
    is also<activate-action-full>
  {
    g_remote_action_group_activate_action_full(
      $!rag,
      $action_name,
      $parameter,
      $platform_data
    );
  }

  method change_action_state_full (
    Str() $action_name,
    GVariant() $value,
    GVariant() $platform_data
  )
    is also<change-action-state-full>
  {
    g_remote_action_group_change_action_state_full(
      $!rag,
      $action_name,
      $value,
      $platform_data
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_remote_action_group_get_type, $n, $t );
  }

}


### /usr/include/glib-2.0/gio/gremoteactiongroup.h

sub g_remote_action_group_activate_action_full (
  GRemoteActionGroup $remote,
  Str $action_name,
  GVariant $parameter,
  GVariant $platform_data
)
  is native(gio)
  is export
{ * }

sub g_remote_action_group_change_action_state_full (
  GRemoteActionGroup $remote,
  Str $action_name,
  GVariant $value,
  GVariant $platform_data
)
  is native(gio)
  is export
{ * }

sub g_remote_action_group_get_type ()
  returns GType
  is native(gio)
  is export
{ * }
