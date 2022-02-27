use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::Printer:ver<3.0.1146>;

sub gtk_printer_accepts_pdf (GtkPrinter $printer)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_printer_accepts_ps (GtkPrinter $printer)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_printer_compare (GtkPrinter $a, GtkPrinter $b)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_printer_get_backend (GtkPrinter $printer)
  returns GtkPrintBackend
  is native(gtk)
  is export
  { * }

sub gtk_printer_get_capabilities (GtkPrinter $printer)
  returns uint32 # GtkPrintCapabilities
  is native(gtk)
  is export
  { * }

sub gtk_printer_get_default_page_size (GtkPrinter $printer)
  returns GtkPageSetup
  is native(gtk)
  is export
  { * }

sub gtk_printer_get_description (GtkPrinter $printer)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_printer_get_hard_margins (
  GtkPrinter $printer,
  gdouble $top,
  gdouble $bottom,
  gdouble $left,
  gdouble $right
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_printer_get_icon_name (GtkPrinter $printer)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_printer_get_job_count (GtkPrinter $printer)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_printer_get_location (GtkPrinter $printer)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_printer_get_name (GtkPrinter $printer)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_printer_get_state_message (GtkPrinter $printer)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_printer_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_enumerate_printers (
  &func (GtkPrinter, gpointer --> gboolean),
  gpointer $data,
  GDestroyNotify $destroy,
  gboolean $wait
)
  is native(gtk)
  is export
  { * }

sub gtk_printer_has_details (GtkPrinter $printer)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_printer_is_accepting_jobs (GtkPrinter $printer)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_printer_is_active (GtkPrinter $printer)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_printer_is_default (GtkPrinter $printer)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_printer_is_paused (GtkPrinter $printer)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_printer_is_virtual (GtkPrinter $printer)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_printer_list_papers (GtkPrinter $printer)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_printer_new (
  gchar $name,
  GtkPrintBackend $backend,
  gboolean $virtual
)
  returns GtkPrinter
  is native(gtk)
  is export
  { * }

sub gtk_printer_request_details (GtkPrinter $printer)
  is native(gtk)
  is export
  { * }
