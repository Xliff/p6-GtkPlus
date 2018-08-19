use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Fixed;
use GTK::Raw::Types;

use GTK::Container;

class GTK::Fixed is GTK::Container {
  has GtkFixed $!f;

  submethod BUILD(:$fixed) {
    given $fixed {
      when GtkFixed | GtkWidget {
        $!f = nativecast(GtkFixed, $fixed);
        self.setContainer($fixed);
      }
      when GTK::Fixed {
      }
      default {
      }
    }
  }

  method new () {
    my $fixed = gtk_fixed_new();
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

  multi method move (GtkWidget $widget, gint $x, gint $y) {
    gtk_fixed_move($!f, $widget, $x, $y);
  }
  multi method move (GTK::Widget $widget, gint $x, gint $y)  {
    samewith($widget.widget, $x, $y);
  }

  multi method put (GtkWidget $widget, gint $x, gint $y) {
    gtk_fixed_put($!f, $widget, $x, $y);
  }
  multi method put (GTK::Widget $widget, gint $x, gint $y)  {
    samewith($widget.widget, $x, $y);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
