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
        $!spin = nativecast(GtkSpinner, $spin);
        self.setParent($spin);
      }
      when GTK::Spinner {
      }
      default {
      }
    }
  }

  method new {
    my $spin = gtk_spinner_new($!spin);
    self.bless(:$spin);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type () {
    gtk_spinner_get_type($!spin);
  }

  method start () {
    gtk_spinner_start($!spin);
  }

  method stop () {
    gtk_spinner_stop($!spin);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
