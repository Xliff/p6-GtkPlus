use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::ActionBar;

sub gtk_action_bar_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_action_bar_new ()
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_action_bar_pack_end (GtkActionBar $action_bar, GtkWidget $child)
  is native('gtk-3')
  is export
  { * }

sub gtk_action_bar_pack_start (GtkActionBar $action_bar, GtkWidget $child)
  is native('gtk-3')
  is export
  { * }

sub gtk_action_bar_get_center_widget (GtkActionBar $action_bar)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_action_bar_set_center_widget (GtkActionBar $action_bar, GtkWidget $center_widget)
  is native('gtk-3')
  is export
  { * }
