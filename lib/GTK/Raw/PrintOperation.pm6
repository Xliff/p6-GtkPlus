use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::PrintOperation;

sub gtk_print_operation_cancel (GtkPrintOperation $op)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_draw_page_finish (GtkPrintOperation $op)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_get_error (
  GtkPrintOperation $op,
  GError $error
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_get_n_pages_to_print (GtkPrintOperation $op)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_get_status (GtkPrintOperation $op)
  returns uint32 # GtkPrintStatus
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_get_status_string (GtkPrintOperation $op)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_error_quark ()
  returns GQuark
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_run_page_setup_dialog (
  GtkWindow $parent,
  GtkPageSetup $page_setup,
  GtkPrintSettings $settings
)
  returns GtkPageSetup
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_run_page_setup_dialog_async (
  GtkWindow $parent,
  GtkPageSetup $page_setup,
  GtkPrintSettings $settings,
  GtkPageSetupDoneFunc $done_cb,
  gpointer $data
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_is_finished (GtkPrintOperation $op)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_new ()
  returns GtkPrintOperation
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_run (
  GtkPrintOperation $op,
  uint32 $a,                  # GtkPrintOperationAction $action,
  GtkWindow $parent,
  GError $error
)
  returns uint32 # GtkPrintOperationResult
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_allow_async (
  GtkPrintOperation $op,
  gboolean $allow_async
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_current_page (
  GtkPrintOperation $op,
  gint $current_page
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_custom_tab_label (
  GtkPrintOperation $op,
  gchar $label
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_defer_drawing (GtkPrintOperation $op)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_export_filename (
  GtkPrintOperation $op,
  gchar $filename
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_job_name (
  GtkPrintOperation $op,
  gchar $job_name
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_n_pages (GtkPrintOperation $op, gint $n_pages)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_show_progress (
  GtkPrintOperation $op,
  gboolean $show_progress
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_track_print_status (
  GtkPrintOperation $op,
  gboolean $track_status
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_unit (
  GtkPrintOperation $op,
  uint32 $uint                # GtkUnit $unit
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_use_full_page (
  GtkPrintOperation $op,
  gboolean $full_page
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_get_embed_page_setup (GtkPrintOperation $op)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_get_support_selection (GtkPrintOperation $op)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_get_print_settings (GtkPrintOperation $op)
  returns GtkPrintSettings
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_get_default_page_setup (GtkPrintOperation $op)
  returns GtkPageSetup
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_get_has_selection (GtkPrintOperation $op)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_embed_page_setup (
  GtkPrintOperation $op,
  gboolean $embed
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_support_selection (
  GtkPrintOperation $op,
  gboolean $support_selection
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_print_settings (
  GtkPrintOperation $op,
  GtkPrintSettings $print_settings
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_default_page_setup (
  GtkPrintOperation $op,
  GtkPageSetup $default_page_setup
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_print_operation_set_has_selection (
  GtkPrintOperation $op,
  gboolean $has_selection
)
  is native($LIBGTK)
  is export
  { * }