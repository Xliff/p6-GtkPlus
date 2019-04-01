use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Value;
use GTK::Compat::Types;
use GTK::Raw::PrintOperation;
use GTK::Raw::Types;

use GTK::Roles::Properties;
use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::PrintOperation;
use GTK::Roles::Types;

use GTK::PageSetup;
use GTK::PrintSettings;

class GTK::PrintOperation {
  also does GTK::Roles::Properties;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::PrintOperation;
  also does GTK::Roles::Types;

  has GtkPrintOperation $!po;

  submethod BUILD(:$op) {
    self!setObject($!po = $op);               # GTK::Roles::Properties
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals, %!signals-po;
  }
  
  method GTK::Raw::Types::GtkPrintOperation is also<PrintOperation> { $!po }

  multi method new (GtkPrintOperation $op) {
    self.bless(:$op);
  }
  multi method new {
    my $op = gtk_print_operation_new();
    self.bless(:$op);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # Is originally:
  # GtkPrintOperation, GtkPrintContext, gpointer --> void
  method begin-print is also<begin_print> {
    self.connect-printcontext($!po, 'begin-print');
  }

  # Is originally:
  # GtkPrintOperation, gpointer --> GObject
  method create-custom-widget is also<create_custom_widget> {
    self.connect($!po, 'create-custom-widget');
  }

  # Is originally:
  # GtkPrintOperation, GtkWidget, gpointer --> void
  method custom-widget-apply is also<custom_widget_apply> {
    self.connect-widget($!po, 'custom-widget-apply');
  }

  # Is originally:
  # GtkPrintOperation, uint32 (GtkPrintOperationResult), gpointer --> void
  method done {
    self.connect-uint($!po, 'done');
  }

  # Is originally:
  # GtkPrintOperation, GtkPrintContext, gint, gpointer --> void
  method draw-page is also<draw_page> {
    self.connect-draw-page($!po);
  }

  # Is originally:
  # GtkPrintOperation, GtkPrintContext, gpointer --> void
  method end-print is also<end_print> {
    self.connect-printcontext($!po, 'end-print');
  }

  # Is originally:
  # GtkPrintOperation, GtkPrintContext, gpointer --> gboolean
  method paginate {
    self.connect-printcontext-rbool($!po, 'paginate');
  }

  # Is originally:
  # GtkPrintOperation, GtkPrintOperationPreview, GtkPrintContext, GtkWindow, gpointer --> gboolean
  method preview {
    self.connect-preview($!po);
  }

  # Is originally:
  # GtkPrintOperation, GtkPrintContext, gint, GtkPageSetup, gpointer --> void
  method request-page-setup is also<request_page_setup> {
    self.connect($!po, 'request-page-setup');
  }

  # Is originally:
  # GtkPrintOperation, gpointer --> void
  method status-changed is also<status_changed> {
    self.connect($!po, 'status-changed');
  }

  # Is originally:
  # GtkPrintOperation, GtkWidget, GtkPageSetup, GtkPrintSettings, gpointer --> void
  method update-custom-widget is also<update_custom_widget> {
    self.connect($!po, 'update-custom-widget');
  }

  # Is originally:
  # GtkPrintOperationPreview, GtkPrintContext, GtkPageSetup, gpointer --> void
  method got-page-size is also<got_page_size> {
    self.connect($!po, 'got-page-size');
  }

  # Is originally:
  # GtkPrintOperationPreview, GtkPrintContext, gpointer --> void
  method ready {
    self.connect-printcontext($!po, 'ready');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method default_page_setup is rw is also<default-page-setup> {
    Proxy.new(
      FETCH => sub ($) {
        GTK::PageSetup.new(
          gtk_print_operation_get_default_page_setup($!po)
        );
      },
      STORE => sub ($, GtkPageSetup() $default_page_setup is copy) {
        gtk_print_operation_set_default_page_setup(
          $!po,
          $default_page_setup
        );
      }
    );
  }

  method embed_page_setup is rw is also<embed-page-setup> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_print_operation_get_embed_page_setup($!po);
      },
      STORE => sub ($, Int() $embed is copy) {
        my gboolean $e = self.RESOLVE-BOOL($embed);
        gtk_print_operation_set_embed_page_setup($!po, $e);
      }
    );
  }

  method has_selection is rw is also<has-selection> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_print_operation_get_has_selection($!po);
      },
      STORE => sub ($, Int() $has_selection is copy) {
        my gboolean $hs = self.RESOLVE-BOOL($has_selection);
        gtk_print_operation_set_has_selection($!po, $hs);
      }
    );
  }

  method print_settings is rw is also<print-settings> {
    Proxy.new(
      FETCH => sub ($) {
        GTK::PrintSettings.new(
          gtk_print_operation_get_print_settings($!po)
        );
      },
      STORE => sub ($, GtkPrintSettings() $print_settings is copy) {
        gtk_print_operation_set_print_settings(
          $!po,
          $print_settings
        );
      }
    );
  }

  method support_selection is rw is also<support-selection> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_print_operation_get_support_selection($!po);
      },
      STORE => sub ($, Int() $support_selection is copy) {
        my gboolean $ss = self.RESOLVE-BOOL($support_selection);
        gtk_print_operation_set_support_selection($!po, $ss);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method allow-async is rw is also<allow_async> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('allow-async', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('allow-async', $gv);
      }
    );
  }

  # Type: gint
  method current-page is rw is also<current_page> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('current-page', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('current-page', $gv);
      }
    );
  }


  # Type: Str()
  method custom-tab-label is rw is also<custom_tab_label> {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('custom-tab-label', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('custom-tab-label', $gv);
      }
    );
  }

  # Type: Str()
  method export-filename is rw is also<export_filename> {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('export-filename', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('export-filename', $gv);
      }
    );
  }

  # Type: Str()
  method job-name is rw is also<job_name> {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('job-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('job-name', $gv);
      }
    );
  }

  # Type: gint
  method n-pages is rw is also<n_pages> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('n-pages', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('n-pages', $gv);
      }
    );
  }

  # Type: gint
  method n-pages-to-print is rw is also<n_pages_to_print> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('n-pages-to-print', $gv)
        );
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn 'GTK::PrintOperation.n-pages-to-print does not allow writing'
      }
    );
  }

  # Type: gboolean
  method show-progress is rw is also<show_progress> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('show-progress', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-progress', $gv);
      }
    );
  }

  # Type: GtkPrintStatus
  method status is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('status', $gv)
        );
        GtkPrintStatus( $gv.enum );
      },
      STORE => -> $, $val is copy {
        warn 'GTK::PrintOperation.status does not allow writing'
      }
    );
  }

  # Type: Str()
  method status-string is rw is also<status_string> {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('status-string', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        warn "status-string does not allow writing"
      }
    );
  }

  # Type: gboolean
  method track-print-status is rw is also<track_print_status> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('track-print-status', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('track-print-status', $gv);
      }
    );
  }

  # Type: GtkUnit
  method unit is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('unit', $gv)
        );
        GtkUnit( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('unit', $gv);
      }
    );
  }

  # Type: gboolean
  method use-full-page is rw is also<use_full_page> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('use-full-page', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-full-page', $gv);
      }
    );
  }
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ STATIC METHODS ↓↓↓↓
  method gtk_print_run_page_setup_dialog (
    GtkWindow() $parent,
    GtkPageSetup() $page_setup,
    GtkPrintSettings() $settings
  )
    is also<gtk-print-run-page-setup-dialog>
  {
    gtk_print_run_page_setup_dialog($parent, $page_setup, $settings);
  }

  method gtk_print_run_page_setup_dialog_async (
    GtkWindow() $parent,
    GtkPageSetup() $page_setup,
    GtkPrintSettings() $settings,
    GtkPageSetupDoneFunc $done_cb,
    gpointer $data = gpointer
  )
    is also<gtk-print-run-page-setup-dialog-async>
  {
    gtk_print_run_page_setup_dialog_async(
      $parent,
      $page_setup,
      $settings,
      $done_cb,
      $data
    );
  }
  # ↑↑↑↑ static METHODS ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method cancel {
    gtk_print_operation_cancel($!po);
  }

  method draw_page_finish is also<draw-page-finish> {
    gtk_print_operation_draw_page_finish($!po);
  }

  method get_error (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-error>
  {
    clear_error;
    my $rc = gtk_print_operation_get_error($!po, $error);
    $ERROR = $error with $error[0];
    $rc;
  }

  method get_n_pages_to_print is also<get-n-pages-to-print> {
    gtk_print_operation_get_n_pages_to_print($!po);
  }

  method get_status is also<get-status> {
    GtkPrintStatus( gtk_print_operation_get_status($!po) );
  }

  method get_status_string is also<get-status-string> {
    gtk_print_operation_get_status_string($!po);
  }

  method get_type is also<get-type> {
    gtk_print_operation_get_type();
  }

  method gtk_print_error_quark is also<gtk-print-error-quark> {
    gtk_print_error_quark();
  }

  method is_finished is also<is-finished> {
    so gtk_print_operation_is_finished($!po);
  }

  method run (
    Int() $action,
    GtkWindow() $parent,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my guint $a = self.RESOLVE-UINT($action);
    my $rc = gtk_print_operation_run($!po, $a, $parent, $error);
    $ERROR = $error with $error[0];
    $rc;
  }

  method set_allow_async (Int() $allow_async) is also<set-allow-async> {
    my gboolean $aa = self.RESOLVE-BOOL($allow_async);
    gtk_print_operation_set_allow_async($!po, $aa);
  }

  method set_current_page (Int() $current_page) is also<set-current-page> {
    my gint $cp = self.RESOLVE-INT($current_page);
    gtk_print_operation_set_current_page($!po, $cp);
  }

  method set_custom_tab_label (Str() $label) is also<set-custom-tab-label> {
    gtk_print_operation_set_custom_tab_label($!po, $label);
  }

  method set_defer_drawing is also<set-defer-drawing> {
    gtk_print_operation_set_defer_drawing($!po);
  }

  method set_export_filename (Str() $filename)
    is also<set-export-filename>
  {
    gtk_print_operation_set_export_filename($!po, $filename);
  }

  method set_job_name (Str() $job_name) is also<set-job-name> {
    gtk_print_operation_set_job_name($!po, $job_name);
  }

  method set_n_pages (Int() $n_pages) is also<set-n-pages> {
    my gint $np = self.RESOLVE-INT($n_pages);
    gtk_print_operation_set_n_pages($!po, $np);
  }

  method set_show_progress (Int() $show_progress)
    is also<set-show-progress>
  {
    my gboolean $sp = self.RESOLVE-BOOL($show_progress);
    gtk_print_operation_set_show_progress($!po, $sp);
  }

  method set_track_print_status (Int() $track_status)
    is also<set-track-print-status>
  {
    my gboolean $ts = self.RESOLVE-BOOL($track_status);
    gtk_print_operation_set_track_print_status($!po, $ts);
  }

  method set_unit (Int() $unit) is also<set-unit> {
    my guint $u = self.RESOLVE-UINT($unit);
    gtk_print_operation_set_unit($!po, $u);
  }

  method set_use_full_page (Int() $full_page) is also<set-use-full-page> {
    my gboolean $fp = self.RESOLVE-BOOL($full_page);
    gtk_print_operation_set_use_full_page($!po, $fp);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
