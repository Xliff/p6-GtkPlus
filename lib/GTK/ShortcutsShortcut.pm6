use v6.c;

use Method::Also;

use GTK::Raw::Types;

use GLib::Value;
use GTK::Box;

our subset GtkShortcutsShortcutAncestry is export
  where GtkShortcutsShortcut | GtkBoxAncestry;

class GTK::ShortcutsShortcut is GTK::Box {
  has GtkShortcutsShortcut $!s is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$shortcut) {
    self.GtkShortcutsGroup($shortcut) if $shortcut;
  }

  method setGtkShortcutsGroup (GtkShortcutsShortcutAncestry $_) {
    my $to-parent;

    $!s = do {
      when GtkShortcutsShortcut  {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkShortcutsShortcut, $_);
      }
    }
    self.setBox($to-parent);
  }

  method GTK::Raw::Definitions::GtkShortcutsShortcut
    is also<
      ShortcutsShortcut
      GtkShortcutsShortcut
    >
  { $!s }

  method new (GtkShortcutsShortcutAncestry $shortcut, :$ref = True) {
    return Nil unless $shortcut;

    my $o = self.bless(:$shortcut);
    $o.ref if $ref;
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
      FETCH => sub ($) {
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
      FETCH => sub ($) {
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
      FETCH => sub ($) {
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
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('direction', $gv) );
        GtkTextDirectionEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = $val;
        self.prop_set('direction', $gv);
      }
    );
  }

  # Type: GIcon
  method icon is rw {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('icon', $gv) );
        cast(GIcon, $gv.pointer);
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
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('icon-set', $gv) );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        $gv.boolean = $val;
        self.prop_set('icon-set', $gv);
      }
    );
  }

  # Type: GtkShortcutType
  method shortcut-type is rw is also<shortcut_type> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('shortcut-type', $gv) );
        GtkShortcutTypeEnum( $gv.enum );
      },
      STORE => -> $, $val is copy {
        $gv.enum = $val;
        self.prop_set('shortcut-type', $gv);
      }
    );
  }

  # Type: gchar
  method subtitle is rw {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('subtitle-set', $gv) );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('subtitle-set', $gv);
      }
    );
  }

  # Type: gchar
  method title is rw {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
      FETCH => sub ($) {
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
