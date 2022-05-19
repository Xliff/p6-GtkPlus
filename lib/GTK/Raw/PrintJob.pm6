use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::PrintJob:ver<3.0.1146>;

sub gtk_print_job_get_page_ranges (GtkPrintJob $job, gint $n_ranges)
  returns GtkPageRange
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_printer (GtkPrintJob $job)
  returns GtkPrinter
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_settings (GtkPrintJob $job)
  returns GtkPrintSettings
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_status (GtkPrintJob $job)
  returns uint32 # GtkPrintStatus
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_surface (
  GtkPrintJob $job,
  CArray[Pointer[GError]] $error
)
  returns cairo_surface_t
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_title (GtkPrintJob $job)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_print_job_new (
  gchar $title,
  GtkPrinter $printer,
  GtkPrintSettings $settings,
  GtkPageSetup $page_setup
)
  returns GtkPrintJob
  is native(gtk)
  is export
  { * }

sub gtk_print_job_send (
  GtkPrintJob $job,
  GtkPrintJobCompleteFunc $callback,
  gpointer $user_data,
  GDestroyNotify $dnotify
)
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_page_ranges (
  GtkPrintJob $job,
  Pointer $ranges,
  gint $n_ranges
)
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_source_fd (
  GtkPrintJob $job,
  gint $fd,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_source_file (
  GtkPrintJob $job,
  gchar $filename,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_pages (GtkPrintJob $job)
  returns uint32 # GtkPrintPages
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_reverse (GtkPrintJob $job)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_n_up_layout (GtkPrintJob $job)
  returns uint32 # GtkNumberUpLayout
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_n_up (GtkPrintJob $job)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_page_set (GtkPrintJob $job)
  returns uint32 # GtkPageSet
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_rotate (GtkPrintJob $job)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_scale (GtkPrintJob $job)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_track_print_status (GtkPrintJob $job)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_collate (GtkPrintJob $job)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_print_job_get_num_copies (GtkPrintJob $job)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_pages (
  GtkPrintJob $job,
  uint32 $pages               # GtkPrintPages $pages
)
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_reverse (GtkPrintJob $job, gboolean $reverse)
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_n_up_layout (
  GtkPrintJob $job,
  uint32 $l                   # GtkNumberUpLayout $layout
)
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_n_up (GtkPrintJob $job, guint $n_up)
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_page_set (
  GtkPrintJob $job,
  uint32 $set                 # GtkPageSet $page_set
)
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_rotate (GtkPrintJob $job, gboolean $rotate)
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_scale (GtkPrintJob $job, gdouble $scale)
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_track_print_status (
  GtkPrintJob $job,
  gboolean $track_status
)
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_collate (GtkPrintJob $job, gboolean $collate)
  is native(gtk)
  is export
  { * }

sub gtk_print_job_set_num_copies (GtkPrintJob $job, gint $num_copies)
  is native(gtk)
  is export
  { * }
