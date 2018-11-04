use v6.c;

use Method::Also;
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
  method status-changed is also<status_changed> {
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

  method n_up is rw is also<n-up> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_n_up($!prnjob);
      },
      STORE => sub ($, $n_up is copy) {
        gtk_print_job_set_n_up($!prnjob, $n_up);
      }
    );
  }

  method n_up_layout is rw is also<n-up-layout> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_n_up_layout($!prnjob);
      },
      STORE => sub ($, $layout is copy) {
        gtk_print_job_set_n_up_layout($!prnjob, $layout);
      }
    );
  }

  method num_copies is rw is also<num-copies> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_job_get_num_copies($!prnjob);
      },
      STORE => sub ($, $num_copies is copy) {
        gtk_print_job_set_num_copies($!prnjob, $num_copies);
      }
    );
  }

  method page_set is rw is also<page-set> {
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

  method track_print_status is rw is also<track-print-status> {
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
  method page-setup is rw is also<page_setup> {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('page-setup', $gv)
        );
        GTK::PageSetup.new( nativecast(GtkPrintStatus, $gv.object) );
      },
      STORE => -> $, GtkPageSetup() $val is copy {
        $gv.object = $val;
        self.prop_set('page-setup', $gv);
      }
    );
  }

  # Type: GtkPrinter
  method printer is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('printer', $gv)
        );
        GTK::Printer.new( nativecast(GtkPrinter, $gv.object) );
      },
      STORE => -> $, GtkPrinter() $val is copy {
        $gv.object = $val;
        self.prop_set('printer', $gv);
      }
    );
  }

  # Type: GtkPrintSettings
  method settings is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('settings', $gv)
        );
        GTK::PrintSettings.new( nativecast(GtkPrintSettings, $gv.object) );
      },
      STORE => -> $, GtkPrintSettings() $val is copy {
        $gv.object = $val;
        self.prop_set('settings', $gv);
      }
    );
  }

  # Type: gchar
  method title is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('title', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method get_page_ranges (gint $n_ranges) is also<get-page-ranges> {
    gtk_print_job_get_page_ranges($!prnjob, $n_ranges);
  }

  method get_printer is also<get-printer> {
    gtk_print_job_get_printer($!prnjob);
  }

  method get_settings is also<get-settings> {
    gtk_print_job_get_settings($!prnjob);
  }

  method get_status is also<get-status> {
    gtk_print_job_get_status($!prnjob);
  }

  method get_surface (CArray[Pointer[GError]] $error) is also<get-surface> {
    gtk_print_job_get_surface($!prnjob, $error);
  }

  method get_title is also<get-title> {
    gtk_print_job_get_title($!prnjob);
  }

  method get_type is also<get-type> {
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
  ) is also<set-page-ranges> {
    gtk_print_job_set_page_ranges($!prnjob, $ranges, $n_ranges);
  }

  method set_source_fd (
    int $fd,
    CArray[Pointer[GError]] $error
  ) is also<set-source-fd> {
    gtk_print_job_set_source_fd($!prnjob, $fd, $error);
  }

  method set_source_file (
    gchar $filename,
    CArray[Pointer[GError]] $error
  ) is also<set-source-file> {
    gtk_print_job_set_source_file($!prnjob, $filename, $error);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}

