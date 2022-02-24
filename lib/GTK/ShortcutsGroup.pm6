use v6.c;

use Method::Also;

use GTK::Raw::Types;

use GLib::Value;
use GTK::Box;
use GTK::SizeGroup;

our subset GtkShortcutsGroupAncestry is export
  where GtkShortcutsGroup | GtkBoxAncestry;

class GTK::ShortcutsGroup is GTK::Box {
  has GtkShortcutsGroup $!sg is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$group) {
    self.setGtkShortcutsGroup($group) if $group;
  }

  method setGtkShortcutsGroup (GtkShortcutsGroupAncestry $_) {
    my $to-parent;

    $!sg = do {
      when GtkShortcutsGroup {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkShortcutsGroup, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GTK::Raw::Definitions::GtkShortcutsGroup
    is also<
      ShortcutsGroup
      GtkShortcutsGroup
    >
  { $!sg }

  method new (GtkShortcutsGroupAncestry $group, :$ref = True) {
    return Nil unless $group;

    my $o = self.bless(:$group);
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

  # Type: guint
  method height is rw {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('height', $gv) );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'height does not allow writing'
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
        $gv.poiner = $val;
        self.prop_set('title-size-group', $gv);
      }
    );
  }

  # Type: gchar
  method view is rw {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('view', $gv) );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('view', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  # ↑↑↑↑ METHODS ↑↑↑↑

}
