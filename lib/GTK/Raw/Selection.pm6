use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::TargetList:ver<3.0.1146>;

sub gtk_selection_add_target (
  GtkWidget $widget,
  GdkAtom $selection,
  GdkAtom $target,
  guint $info
)
  is native(gtk)
  is export
  { * }

sub gtk_selection_add_targets (
  GtkWidget $widget,
  GdkAtom $selection,
  GtkTargetEntry $targets,
  guint $ntargets
)
  is native(gtk)
  is export
  { * }

sub gtk_selection_clear_targets (
  GtkWidget $widget,
  GdkAtom $selection
)
  is native(gtk)
  is export
  { * }

sub gtk_selection_convert (
  GtkWidget $widget,
  GdkAtom $selection,
  GdkAtom $target,
  guint32 $time
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_copy (GtkSelectionData $data)
  returns GtkSelectionData
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_free (GtkSelectionData $data)
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_get_data (GtkSelectionData $selection_data)
  returns CArray[Str]
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_get_data_type (GtkSelectionData $selection_data)
  returns GdkAtom
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_get_data_with_length (
  GtkSelectionData $selection_data,
  guint            $length
)
  returns guchar
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_get_display (GtkSelectionData $selection_data)
  returns GdkDisplay
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_get_format (GtkSelectionData $selection_data)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_get_length (GtkSelectionData $selection_data)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_get_selection (GtkSelectionData $selection_data)
  returns GdkAtom
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_get_target (GtkSelectionData $selection_data)
  returns GdkAtom
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_get_targets (
  GtkSelectionData $selection_data,
  GdkAtom $targets,
  gint $n_atoms
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_get_text (GtkSelectionData $selection_data)
  returns guchar
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_set (
  GtkSelectionData $selection_data,
  GdkAtom $type,
  gint $format,
  guchar $data,
  gint $length
)
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_set_text (
  GtkSelectionData $selection_data,
  gchar $str,
  gint $len
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_targets_include_image (
  GtkSelectionData $selection_data,
  gboolean $writable
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_targets_include_rich_text (
  GtkSelectionData $selection_data,
  GtkTextBuffer $buffer
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_targets_include_text (GtkSelectionData $selection_data)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_targets_include_uri (GtkSelectionData $selection_data)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_selection_owner_set (
  GtkWidget $widget,
  GdkAtom $selection,
  guint32 $time
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_selection_owner_set_for_display (
  GdkDisplay $display,
  GtkWidget $widget,
  GdkAtom $selection,
  guint32 $time
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_selection_remove_all (GtkWidget $widget)
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_get_uris (GtkSelectionData $selection_data)
  returns CArray[Str]
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_get_pixbuf (GtkSelectionData $selection_data)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_set_uris (
  GtkSelectionData $selection_data,
  CArray[Str] $uris
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_selection_data_set_pixbuf (
  GtkSelectionData $selection_data,
  GdkPixbuf $pixbuf
)
  returns uint32
  is native(gtk)
  is export
  { * }
