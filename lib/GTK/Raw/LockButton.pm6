use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::LockButton:ver<3.0.1146>;

sub gtk_lock_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_lock_button_new (GPermission $permission)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_lock_button_get_permission (GtkLockButton $button)
  returns GPermission
  is native(gtk)
  is export
  { * }

sub gtk_lock_button_set_permission (GtkLockButton $button, GPermission $permission)
  is native(gtk)
  is export
  { * }