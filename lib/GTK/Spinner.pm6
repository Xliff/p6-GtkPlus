use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::Spinner;
use GTK::Raw::Types;

use GTK::Widget;

our subset SpinnerAncestry is export
  where GtkSpinner | WidgetAncestry;

class GTK::Spinner is GTK::Widget {
  has GtkSpinner $!spin is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$spin) {
    my $to-parent;
    given $spin {
      when SpinnerAncestry {
        $!spin = do {
          when GtkSpinner {
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkSpinner, $_);
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
  
  method GTK::Raw::Definitions::GtkSpinner is also<Spinner> { $!spin }

  multi method new (SpinnerAncestry $spin) {
    my $o = self.bless(:$spin);
    $o.upref;
    $o;
  }
  multi method new {
    my $spin = gtk_spinner_new();
    self.bless(:$spin);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_spinner_get_type, $n, $t );
  }

  method start {
    gtk_spinner_start($!spin);
  }

  method stop {
    gtk_spinner_stop($!spin);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
