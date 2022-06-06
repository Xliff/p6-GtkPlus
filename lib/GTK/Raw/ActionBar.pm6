use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::ActionBar:ver<3.0.1146>;

sub gtk_action_bar_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_action_bar_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_action_bar_pack_end (GtkActionBar $action_bar, GtkWidget $child)
  is native(gtk)
  is export
  { * }

sub gtk_action_bar_pack_start (GtkActionBar $action_bar, GtkWidget $child)
  is native(gtk)
  is export
  { * }

sub gtk_action_bar_get_center_widget (GtkActionBar $action_bar)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_action_bar_set_center_widget (GtkActionBar $action_bar, GtkWidget $center_widget)
  is native(gtk)
  is export
  { * }