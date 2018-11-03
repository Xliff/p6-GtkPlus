use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Box;

my subset ParentChild where GtkShortcutsShortcut | GtkWidget;

class GTK::ShortcutsShortcut is GTK::Box {
  has GtkShortcutsShortcut $!s;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ShortcutsShortcut');
    $o;
  }

  submethod BUILD(:$shortcut) {
    my $to-parent;
    given $shortcut {
      when ParentChild {
        $!s = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkShortcutsShortcut, $_);
          }
          when GtkShortcutsShortcut  {
            $to-parent = nativecast(GtkBox, $_);
            $_;
          }
        }
        self.setBox($to-parent);
      }
      when GTK::ShortcutsShortcut {
      }
      default {
      }
    }
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkSizeGroup
  method accel-size-group is rw is also<accel_size_group> {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( warn "accel-size-group does not allow reading" );
        GTK::SizeGroup.new( nativecast(GtkSizeGroup, $gv.pointer) );
      },
      STORE => -> $, GtkSizeGroup() $val is copy {
        $gv.pointer = $val;
        self.prop_set($!s, 'accel-size-group', $gv);
      }
    );
  }

  # Type: gchar
  method accelerator is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!s, 'accelerator', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string;
        self.prop_set($!s, 'accelerator', $gv);
      }
    );
  }

  # Type: gchar
  method action-name is rw is also<action_name> {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!s, 'action-name', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!s, 'action-name', $gv);
      }
    );
  }

  # Type: GtkTextDirection
  method direction is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_ENUM );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!s, 'direction', $gv); );
        GtkTextDirection( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set($!s, 'direction', $gv);
      }
    );
  }

  # Type: GIcon
  method icon is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!s, 'icon', $gv); );
        nativecast(GIcon, $gv.pointer);
      },
      STORE => -> $, GIcon $val is copy {
        $gv.pointer = $val;
        self.prop_set($!s, 'icon', $gv);
      }
    );
  }

  # Type: gboolean
  method icon-set is rw is also<icon_set> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!s, 'icon-set', $gv); );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        $gv.boolean = self.RESOLVE-BOOLEAN($val);
        self.prop_set($!s, 'icon-set', $gv);
      }
    );
  }

  # Type: GtkShortcutType
  method shortcut-type is rw is also<shortcut_type> {
    my GTK::Compat::Value $gv .= new( G_TYPE_ENUM );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!s, 'shortcut-type', $gv); );
        GtkShortcutType( $gv.enum );
      },
      STORE => -> $, $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set($!s, 'shortcut-type', $gv);
      }
    );
  }

  # Type: gchar
  method subtitle is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!s, 'subtitle', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!s, 'subtitle', $gv);
      }
    );
  }

  # Type: gboolean
  method subtitle-set is rw is also<subtitle_set> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!s, 'subtitle-set', $gv); );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!s, 'subtitle-set', $gv);
      }
    );
  }

  # Type: gchar
  method title is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!s, 'title', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!s, 'title', $gv);
      }
    );
  }

  # Type: GtkSizeGroup
  method title-size-group is rw is also<title_size_group> {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( warn "title-size-group does not allow reading" );
        GTK::SizeGroup.new( nativecast(GtkSizeGroup, $gv.pointer) );
      },
      STORE => -> $, GtkSizeGroup() $val is copy {
        $gv.pointer = $val;
        self.prop_set($!s, 'title-size-group', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  # ↑↑↑↑ METHODS ↑↑↑↑

}

