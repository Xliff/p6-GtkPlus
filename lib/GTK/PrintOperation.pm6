use v6.c;

use NativeCall;

use GTK::Compat::Value;
use GTK::Compat::Types;
use GTK::Raw::PrintOperation;
use GTK::Raw::Types;

use GTK::Roles::Properties;
use GTK::Roles::Signals::Generic;
use GTK::Roles::Types;

class GTK::PrintOperation {
  also does GTK::Roles::Properties;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Types;

  has GtkPrintOperation $!po;

  submethod BUILD(:$op) {
    $!po = $op;
  }

  multi method new (GtkPrintOperation $op) {
    self.bless(:$op);
  }
  multi method new {
    my $op = gtk_print_operation_new();
    self.bless(:$op);
  }

  method GTK::Raw::Types::GtkPrintOperation {
    $!po;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # Is originally:
  # GtkPrintOperation, GtkPrintContext, gpointer --> void
  method begin-print {
    self.connect($!po, 'begin-print');
  }

  # Is originally:
  # GtkPrintOperation, gpointer --> GObject
  method create-custom-widget {
    self.connect($!po, 'create-custom-widget');
  }

  # Is originally:
  # GtkPrintOperation, GtkWidget, gpointer --> void
  method custom-widget-apply {
    self.connect($!po, 'custom-widget-apply');
  }

  # Is originally:
  # GtkPrintOperation, uint32 (GtkPrintOperationResult), gpointer --> void
  method done {
    self.connect-uint($!po, 'done');
  }

  # Is originally:
  # GtkPrintContext, gint, gpointer --> void
  method draw-page {
    self.connect-int($!po, 'draw-page');
  }

  # Is originally:
  # GtkPrintOperation, GtkPrintContext, gpointer --> void
  method end-print {
    self.connect($!po, 'end-print');
  }

  # Is originally:
  # GtkPrintOperation, GtkPrintContext, gpointer --> gboolean
  method paginate {
    self.connect($!po, 'paginate');
  }

  # Is originally:
  # GtkPrintOperation, GtkPrintOperationPreview, GtkPrintContext, GtkWindow, gpointer --> gboolean
  method preview {
    self.connect($!po, 'preview');
  }

  # Is originally:
  # GtkPrintOperation, GtkPrintContext, gint, GtkPageSetup, gpointer --> void
  method request-page-setup {
    self.connect($!po, 'request-page-setup');
  }

  # Is originally:
  # GtkPrintOperation, gpointer --> void
  method status-changed {
    self.connect($!po, 'status-changed');
  }

  # Is originally:
  # GtkPrintOperation, GtkWidget, GtkPageSetup, GtkPrintSettings, gpointer --> void
  method update-custom-widget {
    self.connect($!po, 'update-custom-widget');
  }

  # Is originally:
  # GtkPrintOperationPreview, GtkPrintContext, GtkPageSetup, gpointer --> void
  method got-page-size {
    self.connect($!po, 'got-page-size');
  }

  # Is originally:
  # GtkPrintOperationPreview, GtkPrintContext, gpointer --> void
  method ready {
    self.connect($!po, 'ready');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method default_page_setup is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_operation_get_default_page_setup($!po);
      },
      STORE => sub ($, $default_page_setup is copy) {
        gtk_print_operation_set_default_page_setup(
          $!po,
          $default_page_setup
        );
      }
    );
  }

  method embed_page_setup is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_operation_get_embed_page_setup($!po);
      },
      STORE => sub ($, $embed is copy) {
        gtk_print_operation_set_embed_page_setup($!po, $embed);
      }
    );
  }

  method has_selection is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_operation_get_has_selection($!po);
      },
      STORE => sub ($, $has_selection is copy) {
        gtk_print_operation_set_has_selection($!po, $has_selection);
      }
    );
  }

  method print_settings is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_operation_get_print_settings($!po);
      },
      STORE => sub ($, $print_settings is copy) {
        gtk_print_operation_set_print_settings(
          $!po,
          $print_settings
        );
      }
    );
  }

  method support_selection is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_print_operation_get_support_selection($!po);
      },
      STORE => sub ($, $support_selection is copy) {
        gtk_print_operation_set_support_selection(
          $!po,
          $support_selection
        );
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method allow-async is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!po, 'allow-async', $gv)
        );
        $gv.get_boolean;
      },
      STORE => -> $, $val is copy {
        $gv.set_boolean($val);
        self.prop_set($!po, 'allow-async', $gv);
      }
    );
  }

  # Type: gint
  method current-page is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!po, 'current-page', $gv)
        );
        $gv.get_int;
      },
      STORE => -> $, $val is copy {
        $gv.set_int($val);
        self.prop_set($!po, 'current-page', $gv);
      }
    );
  }


  # Type: Str()
  method custom-tab-label is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!po, 'custom-tab-label', $gv)
        );
        $gv.get_string;
      },
      STORE => -> $, $val is copy {
        $gv.set_string($val);
        self.prop_set($!po, 'custom-tab-label', $gv);
      }
    );
  }

  # Type: Str()
  method export-filename is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!po, 'export-filename', $gv)
        );
        $gv.get_string;
      },
      STORE => -> $, $val is copy {
        $gv.set_string($val);
        self.prop_set($!po, 'export-filename', $gv);
      }
    );
  }


  # Type: Str()
  method job-name is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!po, 'job-name', $gv)
        );
        $gv.get_string;
      },
      STORE => -> $, $val is copy {
        $gv.set_string($val);
        self.prop_set($!po, 'job-name', $gv);
      }
    );
  }


  # Type: gint
  method n-pages is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!po, 'n-pages', $gv)
        );
        $gv.get_int;
      },
      STORE => -> $, $val is copy {
        $gv.set_int($val);
        self.prop_set($!po, 'n-pages', $gv);
      }
    );
  }

  # Type: gint
  method n-pages-to-print is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!po, 'n-pages-to-print', $gv)
        );
        $gv.get_int;
      },
      STORE => -> $, $val is copy {
        warn "n-pages-to-print does not allow writing"
      }
    );
  }

  # Type: gboolean
  method show-progress is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!po, 'show-progress', $gv)
        );
        $gv.get_boolean;
      },
      STORE => -> $, $val is copy {
        $gv.set_boolean($val);
        self.prop_set($!po, 'show-progress', $gv);
      }
    );
  }

  # Type: GtkPrintStatus
  method status is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_ENUM );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!po, 'status', $gv)
        );
        GtkPrintStatus( $gv.get_enum );
      },
      STORE => -> $, $val is copy {
        warn "status does not allow writing"
      }
    );
  }

  # Type: Str()
  method status-string is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!po, 'status-string', $gv)
        );
        $gv.get_string;
      },
      STORE => -> $, $val is copy {
        warn "status-string does not allow writing"
      }
    );
  }

  # Type: gboolean
  method track-print-status is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!po, 'track-print-status', $gv)
        );
        $gv.get_boolean;
      },
      STORE => -> $, $val is copy {
        $gv.set_boolean($val);
        self.prop_set($!po, 'track-print-status', $gv);
      }
    );
  }

  # Type: GtkUnit
  method unit is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_ENUM );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!po, 'unit', $gv)
        );
        GtkUnit( $gv.get_TYPE );
      },
      STORE => -> $, Int() $val is copy {
        my guint $v = self.RESOLVE-UINT($val);
        $gv.set_enum($v);
        self.prop_set($!po, 'unit', $gv);
      }
    );
  }

  # Type: gboolean
  method use-full-page is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get( $!po, 'use-full-page', $gv)
        );
        $gv.get_boolean;
      },
      STORE => -> $, $val is copy {
        $gv.set_boolean($val);
        self.prop_set($!po, 'use-full-page', $gv);
      }
    );
  }
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ STATIC METHODS ↓↓↓↓
  method gtk_print_run_page_setup_dialog (
    GtkWindow() $parent,
    GtkPageSetup() $page_setup,
    GtkPrintSettings() $settings
  ) {
    gtk_print_run_page_setup_dialog($parent, $page_setup, $settings);
  }

  method gtk_print_run_page_setup_dialog_async (
    GtkWindow() $parent,
    GtkPageSetup() $page_setup,
    GtkPrintSettings() $settings,
    GtkPageSetupDoneFunc $done_cb,
    gpointer $data = gpointer
  ) {
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

  method draw_page_finish {
    gtk_print_operation_draw_page_finish($!po);
  }

  method get_error (GError $error) {
    gtk_print_operation_get_error($!po, $error);
  }

  method get_n_pages_to_print {
    gtk_print_operation_get_n_pages_to_print($!po);
  }

  method get_status {
    gtk_print_operation_get_status($!po);
  }

  method get_status_string {
    gtk_print_operation_get_status_string($!po);
  }

  method get_type {
    gtk_print_operation_get_type();
  }

  method gtk_print_error_quark {
    gtk_print_error_quark();
  }

  method is_finished {
    gtk_print_operation_is_finished($!po);
  }

  method run (
    GtkPrintOperationAction $action,
    GtkWindow $parent,
    GError $error = GError
  ) {
    gtk_print_operation_run($!po, $action, $parent, $error);
  }

  method set_allow_async (gboolean $allow_async) {
    gtk_print_operation_set_allow_async($!po, $allow_async);
  }

  method set_current_page (gint $current_page) {
    gtk_print_operation_set_current_page($!po, $current_page);
  }

  method set_custom_tab_label (Str() $label) {
    gtk_print_operation_set_custom_tab_label($!po, $label);
  }

  method set_defer_drawing {
    gtk_print_operation_set_defer_drawing($!po);
  }

  method set_export_filename (Str() $filename) {
    gtk_print_operation_set_export_filename($!po, $filename);
  }

  method set_job_name (Str() $job_name) {
    gtk_print_operation_set_job_name($!po, $job_name);
  }

  method set_n_pages (gint $n_pages) {
    gtk_print_operation_set_n_pages($!po, $n_pages);
  }

  method set_show_progress (gboolean $show_progress) {
    gtk_print_operation_set_show_progress($!po, $show_progress);
  }

  method set_track_print_status (gboolean $track_status) {
    gtk_print_operation_set_track_print_status($!po, $track_status);
  }

  method set_unit (Int() $unit) {
    my guint $u = self.RESOLVE-UINT($unit);
    gtk_print_operation_set_unit($!po, $u);
  }

  method set_use_full_page (gboolean $full_page) {
    gtk_print_operation_set_use_full_page($!po, $full_page);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
