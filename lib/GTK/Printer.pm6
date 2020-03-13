use v6.c;

use Method::Also;

use GLib::GList;

use GTK::Raw::Printer;
use GTK::Raw::Types;

use GLib::Value;
use GTK::PageSetup;

use GLib::Roles::Properties;
use GTK::Roles::Signals::Generic;
use GTK::Roles::Types;

class GTK::Printer {
  also does GLib::Roles::Properties;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Types;

  has GtkPrinter $!prn is implementor;

  submethod BUILD(:$printer) {
    self!setObject($!prn = $printer);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  method GTK::Raw::Definitions::GtkPrinter
    is also<
      Printer
      GtkPrinter
    >
  { $!prn }

  multi method new (GtkPrinter $printer) {
    $printer ?? self.bless(:$printer) !! Nil;
  }
  multi method new (
    Str $name,
    GtkPrintBackend() $backend,
    Int() $virtual
  ) {
    my gboolean $v = $virtual.so.Int;

    my $printer = gtk_printer_new($name, $backend, $v);

    $printer ?? self.bless(:$printer) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkPrinter, gboolean, gpointer --> void
  method details-acquired is also<details_acquired> {
    self.connect-uint($!prn, 'details-acquired');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method accepting-jobs is rw is also<accepting_jobs> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get( $!prn, 'accepting-jobs', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        warn "accepting-jobs does not allow writing"
      }
    );
  }

  # Type: GtkPrintBackend
  method backend is rw {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get( $!prn, 'backend', $gv)
        );
        cast(GtkPrintBackend, $gv.object);
      },
      STORE => -> $, GtkPrintBackend() $val is copy {
        $gv.object = $val;
        self.prop_set('backend', $gv);
      }
    );
  }

  # Type: gchar
  method icon-name is rw is also<icon_name> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get( $!prn, 'icon-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        warn "icon-name does not allow writing"
      }
    );
  }

  # Type: gint
  method job-count is rw is also<job_count> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get( $!prn, 'name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: gboolean
  method paused is rw {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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
  method state-message is rw is also<state_message> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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

  method compare (GtkPrinter() $a, GtkPrinter() $b) {
    so gtk_printer_compare($a, $b);
  }

  proto method enumerate_printers (|)
    is also<enumerate-printers>
  { * }

  multi method enumerate_printers (
    &func,
    gpointer $data = gpointer
  ) {
    samewith(&func, $data);
  }
  multi method enumerate_printers (&func, Int() $wait) {
    samewith(&func, gpointer, GDestroyNotify, $wait);
  }
  multi method enumerate_printers (
    &func,
    gpointer $data          = gpointer,
    GDestroyNotify $destroy = GDestroyNotify,
    Int() $wait             = True.Int
  ) {
    my gboolean $w = $wait.so.Int;

    gtk_enumerate_printers(&func, $data, $destroy, $w);
  }

  # ↓↓↓↓ METHODS ↓↓↓↓
  method accepts_pdf is also<accepts-pdf> {
    so gtk_printer_accepts_pdf($!prn);
  }

  method accepts_ps is also<accepts-ps> {
    so gtk_printer_accepts_ps($!prn);
  }

  method get_backend
    is also<
      get-backend
    >
  {
    gtk_printer_get_backend($!prn);
  }

  method get_capabilities
    is also<
      get-capabilities
      capabilities
    >
  {
    # cw: Need a way to enumerate flag enums!
    gtk_printer_get_capabilities($!prn);
  }

  method get_default_page_size
    is also<
      get-default-page-size
      default-page-size
      default_page_size
    >
  {
    gtk_printer_get_default_page_size($!prn);
  }

  method get_description
    is also<
      get-description
      description
    >
  {
    gtk_printer_get_description($!prn);
  }

  proto method get_hard_margins (|)
    is also<get-hard-margins>
  { * }

  multi method get_hard_margins is also<hard-margins> {
    samewith($, $, $, $)
  }
  multi method get_hard_margins (
    $top    is rw,
    $bottom is rw,
    $left   is rw,
    $right  is rw
  ) {
    my gdouble ($t, $b, $l, $r) = 0x0 xx 4;

    gtk_printer_get_hard_margins($!prn, $t, $b, $l, $r);
    ($top, $bottom, $left, $right) = ($t, $b, $l, $r);
  }

  method get_icon_name
    is also<
      get-icon-name
    >
  {
    gtk_printer_get_icon_name($!prn);
  }

  method get_job_count
    is also<
      get-job-count
    >
  {
    gtk_printer_get_job_count($!prn);
  }

  method get_location
    is also<
      get-location
    >
  {
    gtk_printer_get_location($!prn);
  }

  method get_name
    is also<
      get-name
    >
  {
    gtk_printer_get_name($!prn);
  }

  method get_state_message
    is also<
      get-state-message
    >
  {
    gtk_printer_get_state_message($!prn);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_printer_get_type, $n, $t );
  }

  method has_details is also<has-details> {
    so gtk_printer_has_details($!prn);
  }

  method is_accepting_jobs is also<is-accepting-jobs> {
    so gtk_printer_is_accepting_jobs($!prn);
  }

  method is_active is also<is-active> {
    so gtk_printer_is_active($!prn);
  }

  method is_default is also<is-default> {
    so gtk_printer_is_default($!prn);
  }

  method is_paused is also<is-paused> {
    so gtk_printer_is_paused($!prn);
  }

  method is_virtual is also<is-virtual> {
    so gtk_printer_is_virtual($!prn);
  }

  method list_papers (:$glist = False, :$raw = False) is also<list-papers> {
    my $pl = gtk_printer_list_papers($!prn);

    return Nil unless $pl;
    return $pl if $glist;

    $pl = GLib::GList.new($pl) but GLib::Roles::ListData[GtkPageSetup];
    $raw ?? $pl.Array !! $pl.Array.map({ GTK::PageSetup.new($_) });
  }

  method request_details is also<request-details> {
    gtk_printer_request_details($!prn);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
