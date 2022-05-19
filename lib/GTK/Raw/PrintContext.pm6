use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;
use Pango::Raw::Types;

unit package GTK::Raw::PrintContext:ver<3.0.1146>;

sub gtk_print_context_create_pango_context (GtkPrintContext $context)
  returns PangoContext
  is native(gtk)
  is export
  { * }

sub gtk_print_context_create_pango_layout (GtkPrintContext $context)
  returns PangoLayout
  is native(gtk)
  is export
  { * }

sub gtk_print_context_get_cairo_context (GtkPrintContext $context)
  returns cairo_t
  is native(gtk)
  is export
  { * }

sub gtk_print_context_get_dpi_x (GtkPrintContext $context)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_print_context_get_dpi_y (GtkPrintContext $context)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_print_context_get_hard_margins (
  GtkPrintContext $context,
  gdouble $top,
  gdouble $bottom,
  gdouble $left,
  gdouble $right
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_print_context_get_height (GtkPrintContext $context)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_print_context_get_page_setup (GtkPrintContext $context)
  returns GtkPageSetup
  is native(gtk)
  is export
  { * }

sub gtk_print_context_get_pango_fontmap (GtkPrintContext $context)
  returns PangoFontMap
  is native(gtk)
  is export
  { * }

sub gtk_print_context_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_print_context_get_width (GtkPrintContext $context)
  returns gdouble
  is native(gtk)
  is export
  { * }

sub gtk_print_context_set_cairo_context (
  GtkPrintContext $context,
  cairo_t $cr,
  gdouble $dpi_x,
  gdouble $dpi_y
)
  is native(gtk)
  is export
  { * }
