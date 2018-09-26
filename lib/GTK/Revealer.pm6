use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Revealer;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::Revealer is GTK::Bin {
  has GtkRevealer $!r;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Revealer');
    $o;
  }

  submethod BUILD(:$revealer) {
    my $to-parent;
    given $ {
      when GtkRevealer | GtkWidget {
        $!r = do {
          when GtkWidget {
            $to-parent = $_
            nativecast(GtkRevealer, $_);
          }
          when GtkRevealer {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
        }
        self.setBin($to-parent);
      }
      when GTK::Revealer {
      }
      default {
      }
    }
  }

  multi method new {
    my $revealer = gtk_revealer_new();
    self.bless(:$revealer);
  }
  multi method new (GtkWidget $revealer) {
    self.bless(:$revealer);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method reveal_child is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_revealer_get_reveal_child($!r);
      },
      STORE => sub ($, $reveal_child is copy) {
        my gboolean $rc = self.RESOLVE-BOOL($reveal_child);
        gtk_revealer_set_reveal_child($!r, $rc);
      }
    );
  }

  method transition_duration is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_revealer_get_transition_duration($!r);
      },
      STORE => sub ($, Int() $duration is copy) {
        my guint $d = self.RESOLVE-UINT($duration);
        gtk_revealer_set_transition_duration($!r, $d);
      }
    );
  }

  method transition_type is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkRevealerTransitionType( gtk_revealer_get_transition_type($!r) );
      },
      STORE => sub ($, Int() $transition is copy) {
        my uint32 $t = self.RESOLVE-UINT($transition);
        gtk_revealer_set_transition_type($!r, $t);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_child_revealed {
    gtk_revealer_get_child_revealed($!r);
  }

  method get_type {
    gtk_revealer_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
