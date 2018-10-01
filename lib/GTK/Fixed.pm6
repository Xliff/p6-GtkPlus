use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Fixed;
use GTK::Raw::Types;

use GTK::Container;

class GTK::Fixed is GTK::Container {
  has GtkFixed $!f;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Fixed');
    $o;
  }

  submethod BUILD(:$fixed) {
    my $to-parent;
    given $fixed {
      when GtkFixed | GtkWidget {
        $!f = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkFixed, $_);
          }
          when GtkFixed {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
        };
        self.setContainer($to-parent);
      }
      when GTK::Fixed {
      }
      default {
      }
    }
  }

  multi method new {
    my $fixed = gtk_fixed_new();
    self.bless(:$fixed);
  }
  multi method new (GtkWidget $fixed) {
    self.bless(:$fixed);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_fixed_get_type();
  }

  multi method move (GtkWidget() $widget, Int() $x, Int() $y) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_fixed_move($!f, $widget, $xx, $yy);
  }

  multi method put (GtkWidget $widget, Int() $x, Int() $y) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_fixed_put($!f, $widget, $xx, $yy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
