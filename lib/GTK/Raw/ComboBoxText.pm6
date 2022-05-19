use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::ComboBoxText:ver<3.0.1146>;

sub gtk_combo_box_text_append (
  GtkComboBoxText $combo_box,
  gchar $id,
  gchar $text
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_text_append_text (GtkComboBoxText $combo_box, gchar $text)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_text_get_active_text (GtkComboBoxText $combo_box)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_text_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_text_insert (
  GtkComboBoxText $combo_box,
  gint $position,
  gchar $id,
  gchar $text
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_text_insert_text (
  GtkComboBoxText $combo_box,
  gint $position,
  gchar $text
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_text_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_text_new_with_entry ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_text_prepend (
  GtkComboBoxText $combo_box,
  gchar $id,
  gchar $text
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_text_prepend_text (GtkComboBoxText $combo_box, gchar $text)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_text_remove (GtkComboBoxText $combo_box, gint $position)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_text_remove_all (GtkComboBoxText $combo_box)
  is native(gtk)
  is export
  { * }