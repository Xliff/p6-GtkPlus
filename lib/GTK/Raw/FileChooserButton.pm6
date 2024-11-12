use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::FileChooser:ver<3.0.1146>;

sub gtk_file_chooser_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_file_chooser_button_new (
  Str $title,
  uint32 $action                # GtkFileChooserAction $action
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_file_chooser_button_new_with_dialog (GtkWidget $dialog)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_file_chooser_button_get_width_chars (GtkFileChooserButton $button)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_file_chooser_button_get_focus_on_click (GtkFileChooserButton $button)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_file_chooser_button_get_title (GtkFileChooserButton $button)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_file_chooser_button_set_width_chars (
  GtkFileChooserButton $button,
  gint $n_chars
)
  is native(gtk)
  is export
  { * }

sub gtk_file_chooser_button_set_focus_on_click (
  GtkFileChooserButton $button,
  gboolean $focus_on_click
)
  is native(gtk)
  is export
  { * }

sub gtk_file_chooser_button_set_title (
  GtkFileChooserButton $button,
  Str $title
)
  is native(gtk)
  is export
  { * }