use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::Switch:ver<3.0.1146>;

sub gtk_switch_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_switch_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_switch_get_active (GtkSwitch $sw)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_switch_get_state (GtkSwitch $sw)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_switch_set_active (GtkSwitch $sw, gboolean $is_active)
  is native(gtk)
  is export
  { * }

sub gtk_switch_set_state (GtkSwitch $sw, gboolean $state)
  is native(gtk)
  is export
  { * }