use v6.c;

use NativeCall;


use GTK::Raw::AppChooser:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

role GTK::Roles::AppChooser:ver<3.0.1146>  {
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

  method get_appchooser_type {
    gtk_app_chooser_get_type();
  }

  method refresh {
    gtk_app_chooser_refresh($!ac);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
