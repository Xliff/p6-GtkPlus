use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::AppButton:ver<3.0.1146>;

sub gtk_app_chooser_button_append_custom_item (
  GtkAppChooserButton $self,
  Str $name,
  Str $label,
  GIcon $icon
)
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_append_separator (GtkAppChooserButton $self)
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_new (Str $content_type)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_set_active_custom_item (
  GtkAppChooserButton $self,
  Str $name
)
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_get_heading (GtkAppChooserButton $self)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_get_show_default_item (GtkAppChooserButton $self)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_get_show_dialog_item (GtkAppChooserButton $self)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_set_heading (
  GtkAppChooserButton $self,
  Str $heading
)
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_set_show_default_item (
  GtkAppChooserButton $self,
  gboolean $setting
)
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_set_show_dialog_item (
  GtkAppChooserButton $self,
  gboolean $setting
)
  is native(gtk)
  is export
  { * }
