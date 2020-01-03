use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Types;

use GLib::Roles::Object;
use GIO::Roles::ActionGroup;
use GIO::Roles::ActionMap;

our subset ActionGroupAncestry is export of Mu
  where GSimpleActionGroup | GActionGroup | GActionMap;

class GIO::SimpleActionGroup {
  also does GLib::Roles::Object;
  also does GIO::Roles::ActionGroup;
  also does GIO::Roles::ActionMap;

  has GSimpleActionGroup $!sag is implementor;

  submethod BUILD (:$group) {
    with $group {
      $!sag = do {
        when GSimpleActionGroup { $_ }
        when GActionGroup       { $!ag = cast(GActionGroup, $_);   proceed; }
        when GActionMap         { $!actmap = cast(GActionMap, $_); proceed; }

        when GActionGroup |
             GActionMap         { cast(GSimpleActionGroup, $_) }
      }
      self.roleInit-Object;
      self.roleInit-ActionMap   unless $!actmap;
      self.roleInit-ActionGroup unless $!ag;
    } else {
      die 'Undefined value passed to GIO::SimpleActionGroup.new';
    }
  }

  multi method new (ActionGroupAncestry $group) {
    self.bless( :$group );
  }
  multi method new {
    my $g = g_simple_action_group_new();
    $g ?? self.bless( group => $g ) !! Nil;
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
