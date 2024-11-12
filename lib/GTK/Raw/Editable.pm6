use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Editable:ver<3.0.1146>;

sub gtk_editable_copy_clipboard (GtkEditable $editable)
  is native(gtk)
  is export
  { * }

sub gtk_editable_cut_clipboard (GtkEditable $editable)
  is native(gtk)
  is export
  { * }

sub gtk_editable_delete_selection (GtkEditable $editable)
  is native(gtk)
  is export
  { * }

sub gtk_editable_delete_text (
  GtkEditable $editable,
  gint $start_pos,
  gint $end_pos
)
  is native(gtk)
  is export
  { * }

sub gtk_editable_get_chars (
  GtkEditable $editable,
  gint $start_pos,
  gint $end_pos
)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_editable_get_selection_bounds (
  GtkEditable $editable,
  gint $start_pos,
  gint $end_pos
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_editable_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_editable_insert_text (
  GtkEditable $editable,
  Str $new_text,
  gint $new_text_length,
  gint $position
)
  is native(gtk)
  is export
  { * }

sub gtk_editable_paste_clipboard (GtkEditable $editable)
  is native(gtk)
  is export
  { * }

sub gtk_editable_select_region (
  GtkEditable $editable,
  gint $start_pos,
  gint $end_pos
)
  is native(gtk)
  is export
  { * }

sub gtk_editable_get_position (GtkEditable $editable)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_editable_get_editable (GtkEditable $editable)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_editable_set_position (
  GtkEditable $editable,
  gint $position
)
  is native(gtk)
  is export
  { * }

sub gtk_editable_set_editable (
  GtkEditable $editable,
  gboolean $is_editable
)
  is native(gtk)
  is export
  { * }