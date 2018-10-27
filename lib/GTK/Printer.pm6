use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Printer;
use GTK::Raw::Types;

use GTK::Roles::Properties;
use GTK::Roles::Signals::Generic;
use GTK::Roles::Types;

class GTK::Printer {
  also does GTK::Roles::Properties;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Types;

  has GtkPrinter $!prn;

  submethod BUILD(:$printer) {
    $!prn = $printer
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  multi method new (GtkPrinter() $printer) {
    self.bless(:$printer);
  }
  multi method new (Str $name, GtkPrintBackend() $backend, gboolean $virtual) {
    my $printer = gtk_printer_new($name, $backend, $virtual);
    self.bless(:$printer);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkPrinter, gboolean, gpointer --> void
  method details-acquired {
    self.connect-uint($!prn, 'details-acquired');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method accepting-jobs is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!prn, 'accepting-jobs', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        warn "accepting-jobs does not allow writing"
      }
    );
  }

  # Type: gboolean
  method accepts-pdf is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!prn, 'accepts-pdf', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        $gv.boolean = $val;
        self.prop_set($!prn, 'accepts-pdf', $gv);
      }
    );
  }

  # Type: gboolean
  method accepts-ps is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!prn, 'accepts-ps', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        $gv.boolean = $val;
        self.prop_set($!prn, 'accepts-ps', $gv);
      }
    );
  }

  # Type: GtkPrintBackend
  method backend is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!prn, 'backend', $gv)
        );
        nativecast(GtkPrintBackend, $gv.object);
      },
      STORE => -> $, GtkPrintBackend() $val is copy {
        $gv.object = $val;
        self.prop_set($!prn, 'backend', $gv);
      }
    );
  }

  # Type: gchar
  method icon-name is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!prn, 'icon-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        warn "icon-name does not allow writing"
      }
    );
  }

  # Type: gboolean
  method is-virtual is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!prn, 'is-virtual', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        $gv.boolean = $val;
        self.prop_set($!prn, 'is-virtual', $gv);
      }
    );
  }

  # Type: gint
  method job-count is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!prn, 'job-count', $gv)
        );
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn "job-count does not allow writing"
      }
    );
  }

  # Type: gchar
  method location is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!prn, 'location', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        warn "location does not allow writing"
      }
    );
  }

  # Type: gchar
  method name is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!prn, 'name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        $gv.string = $val;
        self.prop_set($!prn, 'name', $gv);
      }
    );
  }

  # Type: gboolean
  method paused is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!prn, 'paused', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        warn "paused does not allow writing"
      }
    );
  }

  # Type: gchar
  method state-message is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!prn, 'state-message', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        warn "state-message does not allow writing"
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method accepts_pdf {
    gtk_printer_accepts_pdf($!prn);
  }

  method accepts_ps {
    gtk_printer_accepts_ps($!prn);
  }

  method compare (GtkPrinter $b) {
    gtk_printer_compare($!prn, $b);
  }

  method get_backend {
    gtk_printer_get_backend($!prn);
  }

  method get_capabilities {
    gtk_printer_get_capabilities($!prn);
  }

  method get_default_page_size {
    gtk_printer_get_default_page_size($!prn);
  }

  method get_description {
    gtk_printer_get_description($!prn);
  }

  method get_hard_margins (
    Num() $top,
    Num() $bottom,
    Num() $left,
    Num() $right
  ) {
    my gdouble ($t, $b, $l, $r) = ($top, $bottom, $left, $right);
    gtk_printer_get_hard_margins($!prn, $t, $b, $l, $r);
  }

  method get_icon_name {
    gtk_printer_get_icon_name($!prn);
  }

  method get_job_count {
    gtk_printer_get_job_count($!prn);
  }

  method get_location {
    gtk_printer_get_location($!prn);
  }

  method get_name {
    gtk_printer_get_name($!prn);
  }

  method get_state_message {
    gtk_printer_get_state_message($!prn);
  }

  method get_type {
    gtk_printer_get_type();
  }

  method gtk_enumerate_printers (
    GtkPrinterFunc $func,
    gpointer $data,
    GDestroyNotify $destroy,
    gboolean $wait
  ) {
    gtk_enumerate_printers($func, $data, $destroy, $wait);
  }

  method has_details {
    gtk_printer_has_details($!prn);
  }

  method is_accepting_jobs {
    gtk_printer_is_accepting_jobs($!prn);
  }

  method is_active {
    gtk_printer_is_active($!prn);
  }

  method is_default {
    gtk_printer_is_default($!prn);
  }

  method is_paused {
    gtk_printer_is_paused($!prn);
  }

  method is_virtual {
    gtk_printer_is_virtual($!prn);
  }

  method list_papers {
    gtk_printer_list_papers($!prn);
  }

  method request_details {
    gtk_printer_request_details($!prn);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
