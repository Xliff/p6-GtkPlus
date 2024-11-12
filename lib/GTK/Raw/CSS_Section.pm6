use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::CSS_Section:ver<3.0.1146>;

sub gtk_css_section_get_end_line (GtkCssSection $section)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_css_section_get_end_position (GtkCssSection $section)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_css_section_get_file (GtkCssSection $section)
  returns GFile
  is native(gtk)
  is export
  { * }

sub gtk_css_section_get_parent (GtkCssSection $section)
  returns GtkCssSection
  is native(gtk)
  is export
  { * }

sub gtk_css_section_get_section_type (GtkCssSection $section)
  returns guint # GtkCssSectionType
  is native(gtk)
  is export
  { * }

sub gtk_css_section_get_start_line (GtkCssSection $section)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_css_section_get_start_position (GtkCssSection $section)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_css_section_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_css_section_ref (GtkCssSection $section)
  returns GtkCssSection
  is native(gtk)
  is export
  { * }

sub gtk_css_section_unref (GtkCssSection $section)
  is native(gtk)
  is export
  { * }
