use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::RecentChooserMenu:ver<3.0.1146>;

sub gtk_recent_chooser_menu_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_menu_new ()
  returns GtkRecentChooserMenu
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_menu_new_for_manager (GtkRecentManager $manager)
  returns GtkRecentChooserMenu
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_menu_get_show_numbers (GtkRecentChooserMenu $menu)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_menu_set_show_numbers (
  GtkRecentChooserMenu $menu,
  gboolean $show_numbers
)
  is native(gtk)
  is export
  { * }
