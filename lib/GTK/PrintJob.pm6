use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::PrintJob;
use GTK::Raw::Types;

use GTK::Roles::Properties;
use GTK::Roles::Signals::Generic;
use GTK::Roles::Types;

class GTK::PrintJob {
  also does GTK::Roles::Properties;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Types;

  has GtkPrintJob $!prnjob;

  submethod BUILD(:$job) {
    $!prnjob = $job;
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  multi method new(GtkPrintJob() $job) {
    self.bless(:$job);
  }
  multi method new (
    Str() $title,
    GtkPrinter() $printer,
    GtkPrintSettings() $settings,
    GtkPageSetup() $page_setup
  ) {
    my $job = gtk_print_job_new($title, $printer, $settings, $page_setup);
    self.bless(:$job);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkPrintJob, gpointer --> void
  method status-changed {
    self.connect($!prnjob, 'status-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  method collate is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_collate($!prnjob);
      },
      STORE => sub ($, $collate is copy) {
        gtk_print_job_set_collate($!prnjob, $collate);
      }
    );
  }

  method n_up is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_n_up($!prnjob);
      },
      STORE => sub ($, $n_up is copy) {
        gtk_print_job_set_n_up($!prnjob, $n_up);
      }
    );
  }

  method n_up_layout is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_n_up_layout($!prnjob);
      },
      STORE => sub ($, $layout is copy) {
        gtk_print_job_set_n_up_layout($!prnjob, $layout);
      }
    );
  }

  method num_copies is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_num_copies($!prnjob);
      },
      STORE => sub ($, $num_copies is copy) {
        gtk_print_job_set_num_copies($!prnjob, $num_copies);
      }
    );
  }

  method page_set is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_page_set($!prnjob);
      },
      STORE => sub ($, $page_set is copy) {
        gtk_print_job_set_page_set($!prnjob, $page_set);
      }
    );
  }

  method pages is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_pages($!prnjob);
      },
      STORE => sub ($, $pages is copy) {
        gtk_print_job_set_pages($!prnjob, $pages);
      }
    );
  }

  method reverse is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_reverse($!prnjob);
      },
      STORE => sub ($, $reverse is copy) {
        gtk_print_job_set_reverse($!prnjob, $reverse);
      }
    );
  }

  method rotate is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_rotate($!prnjob);
      },
      STORE => sub ($, $rotate is copy) {
        gtk_print_job_set_rotate($!prnjob, $rotate);
      }
    );
  }

  method scale is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_scale($!prnjob);
      },
      STORE => sub ($, $scale is copy) {
        gtk_print_job_set_scale($!prnjob, $scale);
      }
    );
  }

  method track_print_status is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_track_print_status($!prnjob);
      },
      STORE => sub ($, $track_status is copy) {
        gtk_print_job_set_track_print_status($!prnjob, $track_status);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GtkPageSetup
  method page-setup is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!prnjob, 'page-setup', $gv)
        );
        GTK::PageSetup.new( nativecast(GtkPrintStatus, $gv.object) );
      },
      STORE => -> $, GtkPageSetup() $val is copy {
        $gv.object = $val;
        self.prop_set($!prnjob, 'page-setup', $gv);
      }
    );
  }

  # Type: GtkPrinter
  method printer is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!prnjob, 'printer', $gv)
        );
        GTK::Printer.new( nativecast(GtkPrinter, $gv.object) );
      },
      STORE => -> $, GtkPrinter() $val is copy {
        $gv.object = $val;
        self.prop_set($!prnjob, 'printer', $gv);
      }
    );
  }

  # Type: GtkPrintSettings
  method settings is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!prnjob, 'settings', $gv)
        );
        GTK::PrintSettings.new( nativecast(GtkPrintSettings, $gv.object) );
      },
      STORE => -> $, GtkPrintSettings() $val is copy {
        $gv.object = $val;
        self.prop_set($!prnjob, 'settings', $gv);
      }
    );
  }

  # Type: gchar
  method title is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!prnjob, 'title', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        $gv.string = $val;
        self.prop_set($!prnjob, 'title', $gv);
      }
    );
  }
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method get_page_ranges (gint $n_ranges) {
    gtk_print_job_get_page_ranges($!prnjob, $n_ranges);
  }

  method get_printer {
    gtk_print_job_get_printer($!prnjob);
  }

  method get_settings {
    gtk_print_job_get_settings($!prnjob);
  }

  method get_status {
    gtk_print_job_get_status($!prnjob);
  }

  method get_surface (CArray[Pointer[GError]] $error) {
    gtk_print_job_get_surface($!prnjob, $error);
  }

  method get_title {
    gtk_print_job_get_title($!prnjob);
  }

  method get_type {
    gtk_print_job_get_type();
  }

  method send (
    GtkPrintJobCompleteFunc $callback,
    gpointer $user_data = gpointer,
    GDestroyNotify $dnotify = GDestroyNotify
  ) {
    gtk_print_job_send($!prnjob, $callback, $user_data, $dnotify);
  }

  method set_page_ranges (
    GtkPageRange $ranges,
    gint $n_ranges
  ) {
    gtk_print_job_set_page_ranges($!prnjob, $ranges, $n_ranges);
  }

  method set_source_fd (
    int $fd,
    CArray[Pointer[GError]] $error
  ) {
    gtk_print_job_set_source_fd($!prnjob, $fd, $error);
  }

  method set_source_file (
    gchar $filename,
    CArray[Pointer[GError]] $error
  ) {
    gtk_print_job_set_source_file($!prnjob, $filename, $error);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
