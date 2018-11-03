use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Window;

subset ParentChild when GtkShortcutsWindow | GtkWidget;

class GTK::ShortcutsWindow is GTK::Window {
  has GtkShortcutsWindow $!sw;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ShortcutsWindow');
    $o;
  }

  submethod BUILD(:$shortcuts) {
    my $to-parent;
    given $shortcuts {
      when ParentChild {
        $!sw = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkShortcutsWindow, $_);
          }
          when GtkShortcutsWindow {
            $to-parent = nativecast(GtkWindow, $_);
            $_;
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

  method new (ParentChild $shortcuts) {
    self.bless(:$shortcuts);
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
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!sw, 'section-name', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!sw, 'section-name', $gv);
      }
    );
  }

  # Type: gchar
  method view-name is rw is also<view_name> {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get($!sw, 'view-name', $gv); );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!sw, 'view-name', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  # ↑↑↑↑ METHODS ↑↑↑↑

}

