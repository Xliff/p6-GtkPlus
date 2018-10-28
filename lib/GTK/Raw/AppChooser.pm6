use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::AppChooser;

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