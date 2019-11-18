use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::EventBox;
use GTK::Raw::Types;

use GTK::Bin;

use GTK::Roles::Types;

our subset EventBoxAncestry is export 
  where GtkEventBox | BinAncestry;

class GTK::EventBox is GTK::Bin {
  also does GTK::Roles::Types;

  has GtkEventBox $!eb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$box) {
    my $to-parent;
    given $box {
      when EventBoxAncestry {
        $!eb = do {
          when GtkEventBox  {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkEventBox, $_);
          }
        }
        self.setBin($to-parent);
      }
      when GTK::EventBox {
      }
      default {
      }
    }
  }
  
  method GTK::Raw::Types::GtkEventBox is also<EventBox> { $!eb }

  multi method new (EventBoxAncestry $box) {
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
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_event_box_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
