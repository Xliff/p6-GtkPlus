use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GTK::Compat::Roles::ActionMap;
use GTK::Compat::Roles::Object;

class GTK::Compat::SimpleActionGroup {
  also does GTK::Compat::Roles::ActionMap;
  also does GTK::Compat::Roles::Object;

  has GSimpleActionGroup $!sag;

  submethod BUILD (:$group) {
    self!setObject($!sag = $group);
    $!actmap = nativecast(GActionMap, $group);
  }

  method new {
    self.bless( group => g_simple_action_group_new() );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^new, &g_simple_action_group_get_type, $n, $t );
  }

}

sub g_simple_action_group_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_simple_action_group_new ()
  returns GSimpleActionGroup
  is native(gio)
  is export
  { * }
