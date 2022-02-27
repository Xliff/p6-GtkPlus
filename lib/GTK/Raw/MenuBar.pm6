use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::MenuBar:ver<3.0.1146>;

sub gtk_menu_bar_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_menu_bar_new ()
  returns GtkMenuBar
  is native(gtk)
  is export
  { * }

sub gtk_menu_bar_new_from_model (GMenuModel $model)
  returns GtkMenuBar
  is native(gtk)
  is export
  { * }

sub gtk_menu_bar_get_child_pack_direction (GtkMenuBar $menubar)
  returns uint32 # GtkPackDirection
  is native(gtk)
  is export
  { * }

sub gtk_menu_bar_get_pack_direction (GtkMenuBar $menubar)
  returns uint32 # GtkPackDirection
  is native(gtk)
  is export
  { * }

sub gtk_menu_bar_set_child_pack_direction (
  GtkMenuBar $menubar,
  uint32 $child_pack_dir        # GtkPackDirection $child_pack_dir
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_bar_set_pack_direction (
  GtkMenuBar $menubar,
  uint32 $pack_dir              # GtkPackDirection $pack_dir
)
  is native(gtk)
  is export
  { * }
