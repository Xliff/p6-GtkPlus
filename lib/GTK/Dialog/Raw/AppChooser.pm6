use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Dialog::Raw::AppChooser;

sub gtk_app_chooser_dialog_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_app_chooser_dialog_get_widget (GtkAppChooserDialog $self)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_app_chooser_dialog_new (
  GtkWindow $parent,
  uint32 $flags,                # GtkDialogFlags $flags,
  GFile $file
)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_app_chooser_dialog_new_for_content_type (
  GtkWindow $parent,
  uint32 $flags,                # GtkDialogFlags $flags,
  gchar $content_type
)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_app_chooser_dialog_get_heading (GtkAppChooserDialog $self)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_app_chooser_dialog_set_heading (
  GtkAppChooserDialog $self,
  gchar $heading
)
  is native($LIBGTK)
  is export
  { * }