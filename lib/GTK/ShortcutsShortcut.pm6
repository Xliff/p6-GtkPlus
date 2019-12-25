use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GLib::Value;
use GTK::Box;

our subset ShortcutsShortcutAncestry is export
  where GtkShortcutsShortcut | BoxAncestry;

class GTK::ShortcutsShortcut is GTK::Box {
  has GtkShortcutsShortcut $!s is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$shortcut) {
    my $to-parent;
    given $shortcut {
      when ShortcutsShortcutAncestry {
        $!s = do {
          when GtkShortcutsShortcut  {
            $to-parent = nativecast(GtkBox, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkShortcutsShortcut, $_);
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

  method GTK::Raw::Types::GtkShortcutsShortcut
    is also<ShortcutsShortcut>
  { $!s }

  method new (ShortcutsShortcutAncestry $shortcut) {
    my $o = self.bless(:$shortcut);
    $o.upref;
    $o;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkSizeGroup
  method accel-size-group is rw is also<accel_size_group> {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        warn 'accel-size-group does not allow reading' if $DEBUG;
        Nil;
      },
      STORE => -> $, GtkSizeGroup() $val is copy {
        $gv.pointer = $val;
        self.prop_set('accel-size-group', $gv);
      }
    );
  }

  # Type: gchar
  method accelerator is rw {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new( self.prop_get('accelerator', $gv) );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string;
        self.prop_set('accelerator', $gv);
      }
    );
  }

  # Type: gchar
  method action-name is rw is also<action_name> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new( self.prop_get('action-name', $gv) );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('action-name', $gv);
      }
    );
  }

  # Type: GtkTextDirection
  method direction is rw {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new( self.prop_get('direction', $gv) );
        GtkTextDirection( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set('direction', $gv);
      }
    );
  }

  # Type: GIcon
  method icon is rw {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new( self.prop_get('icon', $gv) );
        nativecast(GIcon, $gv.pointer);
      },
      STORE => -> $, GIcon $val is copy {
        $gv.pointer = $val;
        self.prop_set('icon', $gv);
      }
    );
  }

  # Type: gboolean
  method icon-set is rw is also<icon_set> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new( self.prop_get('icon-set', $gv) );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        $gv.boolean = self.RESOLVE-BOOLEAN($val);
        self.prop_set('icon-set', $gv);
      }
    );
  }

  # Type: GtkShortcutType
  method shortcut-type is rw is also<shortcut_type> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new( self.prop_get('shortcut-type', $gv) );
        GtkShortcutType( $gv.enum );
      },
      STORE => -> $, $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set('shortcut-type', $gv);
      }
    );
  }

  # Type: gchar
  method subtitle is rw {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new( self.prop_get('subtitle', $gv) );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('subtitle', $gv);
      }
    );
  }

  # Type: gboolean
  method subtitle-set is rw is also<subtitle_set> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new( self.prop_get('subtitle-set', $gv) );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set('subtitle-set', $gv);
      }
    );
  }

  # Type: gchar
  method title is rw {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new( self.prop_get('title', $gv) );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: GtkSizeGroup
  method title-size-group is rw is also<title_size_group> {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        warn 'title-size-group does not allow reading' if $DEBUG;
        Nil;
      },
      STORE => -> $, GtkSizeGroup() $val is copy {
        $gv.pointer = $val;
        self.prop_set('title-size-group', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  # ↑↑↑↑ METHODS ↑↑↑↑

}
