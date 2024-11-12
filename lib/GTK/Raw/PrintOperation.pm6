use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::PrintOperation:ver<3.0.1146>;

sub gtk_print_operation_cancel (GtkPrintOperation $op)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_draw_page_finish (GtkPrintOperation $op)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_get_error (
  GtkPrintOperation $op,
  CArray[Pointer[GError]] $error
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_get_n_pages_to_print (GtkPrintOperation $op)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_get_status (GtkPrintOperation $op)
  returns uint32 # GtkPrintStatus
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_get_status_string (GtkPrintOperation $op)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_print_error_quark ()
  returns GQuark
  is native(gtk)
  is export
  { * }

sub gtk_print_run_page_setup_dialog (
  GtkWindow $parent,
  GtkPageSetup $page_setup,
  GtkPrintSettings $settings
)
  returns GtkPageSetup
  is native(gtk)
  is export
  { * }

sub gtk_print_run_page_setup_dialog_async (
  GtkWindow $parent,
  GtkPageSetup $page_setup,
  GtkPrintSettings $settings,
  &done_cb (GtkPageSetup, gpointer),
  gpointer $data
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_is_finished (GtkPrintOperation $op)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_new ()
  returns GtkPrintOperation
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_run (
  GtkPrintOperation $op,
  uint32 $a,                  # GtkPrintOperationAction $action,
  GtkWindow $parent,
  CArray[Pointer[GError]] $error
)
  returns uint32 # GtkPrintOperationResult
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_allow_async (
  GtkPrintOperation $op,
  gboolean $allow_async
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_current_page (
  GtkPrintOperation $op,
  gint $current_page
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_custom_tab_label (
  GtkPrintOperation $op,
  Str $label
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_defer_drawing (GtkPrintOperation $op)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_export_filename (
  GtkPrintOperation $op,
  Str $filename
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_job_name (
  GtkPrintOperation $op,
  Str $job_name
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_n_pages (GtkPrintOperation $op, gint $n_pages)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_show_progress (
  GtkPrintOperation $op,
  gboolean $show_progress
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_track_print_status (
  GtkPrintOperation $op,
  gboolean $track_status
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_unit (
  GtkPrintOperation $op,
  uint32 $uint                # GtkUnit $unit
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_use_full_page (
  GtkPrintOperation $op,
  gboolean $full_page
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_get_embed_page_setup (GtkPrintOperation $op)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_get_support_selection (GtkPrintOperation $op)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_get_print_settings (GtkPrintOperation $op)
  returns GtkPrintSettings
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_get_default_page_setup (GtkPrintOperation $op)
  returns GtkPageSetup
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_get_has_selection (GtkPrintOperation $op)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_embed_page_setup (
  GtkPrintOperation $op,
  gboolean $embed
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_support_selection (
  GtkPrintOperation $op,
  gboolean $support_selection
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_print_settings (
  GtkPrintOperation $op,
  GtkPrintSettings $print_settings
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_default_page_setup (
  GtkPrintOperation $op,
  GtkPageSetup $default_page_setup
)
  is native(gtk)
  is export
  { * }

sub gtk_print_operation_set_has_selection (
  GtkPrintOperation $op,
  gboolean $has_selection
)
  is native(gtk)
  is export
  { * }
