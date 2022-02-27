use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;
use GTK::Window:ver<3.0.1146>;

our subset ShortcutsWindowAncestry is export
  when GtkShortcutsWindow | WindowAncestry;

class GTK::ShortcutsWindow:ver<3.0.1146> is GTK::Window {
  has GtkShortcutsWindow $!sw is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$shortcuts) {
    my $to-parent;
    given $shortcuts {
      when ShortcutsWindowAncestry {
        $!sw = do {
          when GtkShortcutsWindow {
            $to-parent = cast(GtkWindow, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkShortcutsWindow, $_);
          }
        }
        self.setWindow($to-parent);
      }
      when GTK::ShortcutsWindow {
      }
      default {
      }
    }
  }

  method new (ShortcutsWindowAncestry $shortcuts, :$ref = True) {
    return Nil unless $shortcuts;

    my $o = self.bless(:$shortcuts);
    $o.ref if $ref;
    $o;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkShortcutsWindow, gpointer --> void
  method close {
    self.connect($!sw, 'close');
  }

  # Is originally:
  # GtkShortcutsWindow, gpointer --> void
  method search {
    self.connect($!sw, 'search');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gchar
  method section-name is rw is also<section_name> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('section-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('section-name', $gv)
      }
    );
  }

  # Type: gchar
  method view-name is rw is also<view_name> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('view-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('view-name', $gv)
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  # ↑↑↑↑ METHODS ↑↑↑↑

}
