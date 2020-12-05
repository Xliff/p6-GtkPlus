use v6.c;

use Method::Also;

use GTK::Raw::Spinner;
use GTK::Raw::Types;

use GTK::Widget;

our subset SpinnerAncestry is export
  where GtkSpinner | GtkWidgetAncestry;

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
            $to-parent = cast(GtkWidget, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkSpinner, $_);
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

  method GTK::Raw::Definitions::GtkSpinner
    is also<
      Spinner
      GtkSpinner
    >
  { $!spin }

  multi method new (SpinnerAncestry $spin, :$ref = True) {
    return Nil unless $spin;

    my $o = self.bless(:$spin);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $spin = gtk_spinner_new();

    $spin ?? self.bless(:$spin) !! Nil;
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
