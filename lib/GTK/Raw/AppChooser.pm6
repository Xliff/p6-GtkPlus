use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::AppChooser:ver<3.0.1146>;

sub gtk_app_chooser_get_app_info (GtkAppChooser $self)
  returns GAppInfo
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_get_content_type (GtkAppChooser $self)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_app_chooser_refresh (GtkAppChooser $self)
  is native(gtk)
  is export
  { * }