use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::ActionBar;
use GTK::Raw::Types;

use GTK::Bin;

our subset ActionBarAncestry is export where GtkActionBar | BinAncestry;

class GTK::ActionBar is GTK::Bin {
  has GtkActionBar $!ab is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ActionBar');
    $o;
  }

  submethod BUILD(:$actionbar) {
    my $to-parent;
    given $actionbar {
      when ActionBarAncestry {
        $!ab = do {
          when GtkActionBar  {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
          when BinAncestry {
            $to-parent = $_;
            nativecast(GtkActionBar, $_);
          }
        }
        self.setBin($to-parent);
      }
      when GTK::ActionBar {
      }
      default {
      }
    }
  }
  
  method GTK::Raw::Types::GtkActionBar is also<ActionBar> { $!ab }

  multi method new (ActionBarAncestry $actionbar) {
    my $o = self.bless(:$actionbar);
    $o.upref;
    $o;
  }
  multi method new {
    my $actionbar = gtk_action_bar_new();
    self.bless(:$actionbar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method center_widget is rw is also<center-widget> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_action_bar_get_center_widget($!ab);
      },
      STORE => sub ($, GtkWidget() $center_widget is copy) {
        gtk_action_bar_set_center_widget($!ab, $center_widget);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_action_bar_get_type, $n, $t );
  }

  multi method pack-end (GtkWidget $child) {
    self.pack_end($child);
  }
  multi method pack_end (GtkWidget $child) {
    self.unshift-end($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_action_bar_pack_end($!ab, $child);
  }
  multi method pack-end (GTK::Widget $child) {
    self.pack_end($child);
  }
  multi method pack_end (GTK::Widget $child) {
    self.SET-LATCH;
    self.unshift-end($child);
    samewith($child.Widget);
  }

  multi method pack-start (GtkWidget $child) {
    self.pack_start($child);
  }
  multi method pack_start (GtkWidget $child) {
    self.unshift-end($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_action_bar_pack_start($!ab, $child);
  }
  multi method pack-start (GTK::Widget $child) {
    self.pack_start($child);
  }
  multi method pack_start (GTK::Widget $child) {
    self.SET-LATCH;
    self.push-start($child.Widget);
    samewith($child.Widget);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method child-set(GtkWidget $c, *@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'pack-type'  { self.child-set-uint($c, $p, $v)  }
        when 'position '  { self.child-set-int($c, $p, $v)   }

        default           { take $p; take $v;                }
      }
    }
    nextwith($c, @notfound) if +@notfound;
  }
}
