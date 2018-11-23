use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::EventBox;
use GTK::Raw::Types;

use GTK::Bin;

use GTK::Roles::Types;

my subset Ancestry where GtkEventBox | GtkBuildable | GtkWidget;

class GTK::EventBox is GTK::Bin {
  also does GTK::Roles::Types;

  has GtkEventBox $!eb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::EventBox');
    $o;
  }

  submethod BUILD(:$box) {
    my $to-parent;
    given $box {
      when Ancestry {
        $!eb = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkEventBox, $_);
          }
          when GtkEventBox  {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
        }
        self.setParent($to-parent);
      }
      when GTK::EventBox {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $box) {
    self.bless(:$box);
  }
  multi method new {
    my $box = gtk_event_box_new();
    self.bless(:$box);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method above_child is rw is also<above-child> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_event_box_get_above_child($!eb);
      },
      STORE => sub ($, Int() $above_child is copy) {
        my gboolean $ab = self.RESOLVE-BOOL($above_child);
        gtk_event_box_set_above_child($!eb, $ab);
      }
    );
  }

  method visible_window is rw is also<visible-window> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_event_box_get_visible_window($!eb);
      },
      STORE => sub ($, Int() $visible_window is copy) {
        my gboolean $vw = self.RESOLVE-BOOL($visible_window);
        gtk_event_box_set_visible_window($!eb, $vw);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_event_box_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
