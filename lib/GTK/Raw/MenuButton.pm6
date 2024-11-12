use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::MenuButton:ver<3.0.1146>;

sub gtk_menu_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_get_popup (GtkMenuButton $menu_button)
  returns GtkMenu
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_get_use_popover (GtkMenuButton $menu_button)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_get_direction (GtkMenuButton $menu_button)
  returns uint32 # GtkArrowType
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_get_popover (GtkMenuButton $menu_button)
  returns GtkPopover
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_get_align_widget (GtkMenuButton $menu_button)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_get_menu_model (GtkMenuButton $menu_button)
  returns GMenuModel
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_set_popup (GtkMenuButton $menu_button, GtkWidget $menu)
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_set_use_popover (
  GtkMenuButton $menu_button,
  gboolean $use_popover
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_set_direction (
  GtkMenuButton $menu_button,
  uint32 $direction               # GtkArrowType $direction
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_set_popover (
  GtkMenuButton $menu_button,
  GtkWidget $popover
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_set_align_widget (
  GtkMenuButton $menu_button,
  GtkWidget $align_widget
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_button_set_menu_model (
  GtkMenuButton $menu_button,
  GMenuModel $menu_model
)
  is native(gtk)
  is export
  { * }
