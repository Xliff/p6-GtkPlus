use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Spinner;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::Spinner is GTK::Widget {
  has GtkSpinner $!spin;

  submethod BUILD(:$spin) {
    given $spin {
      when GtkSpinner | GtkWidget {
        $!spin = do {
          when GtkWidget  { nativecast(GtkSpinner, $spin); }
          when GtkSpinner { $spin; }
        };
        self.setWidget($spin);
      }
      when GTK::Spinner {
      }
      default {
      }
    }
    self.setType('GTK::Spinner');
  }

  method new {
    my $spin = gtk_spinner_new();
    self.bless(:$spin);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type () {
    gtk_spinner_get_type();
  }

  method start () {
    gtk_spinner_start($!spin);
  }

  method stop () {
    gtk_spinner_stop($!spin);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
