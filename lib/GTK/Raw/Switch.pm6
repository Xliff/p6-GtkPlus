use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Switch;

sub gtk_switch_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_switch_new ()
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_switch_get_active (GtkSwitch $sw)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_switch_get_state (GtkSwitch $sw)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_switch_set_active (GtkSwitch $sw, gboolean $is_active)
  is native('gtk-3')
  is export
  { * }

sub gtk_switch_set_state (GtkSwitch $sw, gboolean $state)
  is native('gtk-3')
  is export
  { * }
