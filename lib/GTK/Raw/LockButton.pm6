use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::LockButton;

sub gtk_lock_button_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_lock_button_new (GPermission $permission)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_lock_button_get_permission (GtkLockButton $button)
  returns GPermission
  is native('gtk-3')
  is export
  { * }

sub gtk_lock_button_set_permission (GtkLockButton $button, GPermission $permission)
  is native('gtk-3')
  is export
  { * }
