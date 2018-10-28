use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::AppButton;

sub gtk_app_chooser_button_append_custom_item (GtkAppChooserButton $self, gchar $name, gchar $label, GIcon $icon)
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

sub gtk_app_chooser_button_new (gchar $content_type)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_set_active_custom_item (GtkAppChooserButton $self, gchar $name)
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

sub gtk_app_chooser_button_set_heading (GtkAppChooserButton $self, gchar $heading)
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_set_show_default_item (GtkAppChooserButton $self, gboolean $setting)
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_button_set_show_dialog_item (GtkAppChooserButton $self, gboolean $setting)
  is native(gtk)
  is export
  { * }