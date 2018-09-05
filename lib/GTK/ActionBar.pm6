use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ActionBar;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::ActionBar is GTK::Bin {
  has GtkActionBar $!ab;

  submethod BUILD(:$actionbar) {
    my $to-parent;
    given $actionbar {
      when GtkActionBar | GtkWidget {
        $!ab = do {
          when GtkWidget {
            $to-parent = $_
            nativecast(GtkActionBar, $_);
          }
          when GtkActionBar  {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
        }
        self.setBin($to-parent);
      }
      when GTK::ActionBar {
      }
      default {
      }
    }
    self.setType('GTK::ActionBar');
  }

  method new {
    my $actionbar = gtk_action_bar_new();
    self.bless(:$actionbar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method center_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_action_bar_get_center_widget($!ab);
      },
      STORE => sub ($, $center_widget is copy) {
        my $cw = do given $center_widget {
          when GTK::Widget { .widget }
          when GtkWidget   { $_ }
          default {
            die "Invalid type { .^name } passed to { ::?CLASS }.center_widget()";
          }
        }
        gtk_action_bar_set_center_widget($!ab, $cw);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_action_bar_get_type();
  }

  multi method pack_end (GtkWidget $child) {
    self.unshift-end($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_action_bar_pack_end($!ab, $child);
  }
  multi method pack_end (GTK::Widget $child)  {
    self.SET-LATCH;
    self.unshift-end($child);
    samewith($child.widget);
  }

  multi method pack_start (GtkWidget $child) {
    self.unshift-end($child) unless self.IS-LATCHED;
    self.UNSET-LATCH;
    gtk_action_bar_pack_start($!ab, $child);
  }
  multi method pack_start (GTK::Widget $child)  {
    self.SET-LATCH;
    self.push-start($child.widget);
    samewith($child.widget);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
