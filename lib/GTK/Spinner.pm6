use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Spinner;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::Spinner is GTK::Widget {
  has GtkSpinner $!spin;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Spinner');
    $o;
  }

  submethod BUILD(:$spin) {
    my $to-parent;
    given $spin {
      when GtkSpinner | GtkWidget {
        $!spin = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkSpinner, $_);
          }
          when GtkSpinner {
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }
        };
        self.setWidget($to-parent);
      }
      when GTK::Spinner {
      }
      default {
      }
    }
  }

  multi method new {
    my $spin = gtk_spinner_new();
    self.bless(:$spin);
  }
  multi method new (GtkWidget $spin) {
    self.bless(:$spin);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_spinner_get_type();
  }

  method start {
    gtk_spinner_start($!spin);
  }

  method stop {
    gtk_spinner_stop($!spin);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

