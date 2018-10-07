use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::AppChooser;
use GTK::Raw::Types;

role GTK::Roles::AppChooser  {
  has GtkAppChooser $!ac;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_app_info {
    gtk_app_chooser_get_app_info($!ac);
  }

  # Alias to original name of get_content_type
  # Currently read-only, set method depends on accessing the Gtk Property.
  method content_type {
    gtk_app_chooser_get_content_type($!ac);
  }

  method get_appchooser_role_type {
    gtk_app_chooser_get_type();
  }

  method refresh {
    gtk_app_chooser_refresh($!ac);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
