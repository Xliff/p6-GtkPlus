use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::CheckMenuItem:ver<3.0.1146>;

sub gtk_check_menu_item_get_type ()
  returns GType
  is      native(gtk)
  is      export
{ * }

sub gtk_check_menu_item_new ()
  returns GtkCheckMenuItem
  is      native(gtk)
  is      export
{ * }

sub gtk_check_menu_item_new_with_label (Str $label)
  returns GtkCheckMenuItem
  is      native(gtk)
  is      export
{ * }

sub gtk_check_menu_item_new_with_mnemonic (Str $label)
  returns GtkCheckMenuItem
  is      native(gtk)
  is      export
{ * }

sub gtk_check_menu_item_toggled (GtkCheckMenuItem $check_menu_item)
  is      native(gtk)
  is      export
{ * }

sub gtk_check_menu_item_get_inconsistent (GtkCheckMenuItem $check_menu_item)
  returns uint32
  is      native(gtk)
  is      export
{ * }

sub gtk_check_menu_item_get_active (GtkCheckMenuItem $check_menu_item)
  returns uint32
  is      native(gtk)
  is      export
{ * }

sub gtk_check_menu_item_get_draw_as_radio (GtkCheckMenuItem $check_menu_item)
  returns uint32
  is      native(gtk)
  is      export
{ * }

sub gtk_check_menu_item_set_inconsistent (
  GtkCheckMenuItem $check_menu_item,
  gboolean $setting
)
  is      native(gtk)
  is      export
{ * }

sub gtk_check_menu_item_set_active (
  GtkCheckMenuItem $check_menu_item,
  gboolean $is_active
)
  is      native(gtk)
  is      export
{ * }

sub gtk_check_menu_item_set_draw_as_radio (
  GtkCheckMenuItem $check_menu_item,
  gboolean $draw_as_radio
)
  is      native(gtk)
  is      export
{ * }
