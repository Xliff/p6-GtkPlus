use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::ToggleButton:ver<3.0.1146>;

sub gtk_toggle_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_toggle_button_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_toggle_button_new_with_label (gchar $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_toggle_button_new_with_mnemonic (gchar $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_toggle_button_toggled (GtkToggleButton $toggle_button)
  is native(gtk)
  is export
  { * }

sub gtk_toggle_button_get_mode (GtkToggleButton $toggle_button)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_toggle_button_get_inconsistent (GtkToggleButton $toggle_button)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_toggle_button_get_active (GtkToggleButton $toggle_button)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_toggle_button_set_mode (GtkToggleButton $toggle_button, gboolean $draw_indicator)
  is native(gtk)
  is export
  { * }

sub gtk_toggle_button_set_inconsistent (GtkToggleButton $toggle_button, gboolean $setting)
  is native(gtk)
  is export
  { * }

sub gtk_toggle_button_set_active (GtkToggleButton $toggle_button, gboolean $is_active)
  is native(gtk)
  is export
  { * }