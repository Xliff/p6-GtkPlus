use v6.c;

use NativeCall;

use GTK::Raw::Types;

unit package GTK::Raw::Button;

sub gtk_button_clicked (GtkButton $button)
  is native('gtk-3')
  is export
  { * }

sub gtk_button_get_alignment (GtkButton $button, gfloat $xalign, gfloat $yalign)
  is native('gtk-3')
  is export
  { * }

sub gtk_button_get_event_window (GtkButton $button)
  returns GdkWindow
  is native('gtk-3')
  is export
  { * }

sub gtk_button_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_button_new ()
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_button_new_from_icon_name (gchar $icon_name, GtkIconSize $size)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_button_new_from_stock (gchar $stock_id)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_button_new_with_label (gchar $label)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_button_new_with_mnemonic (gchar $label)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_button_set_alignment (GtkButton $button, gfloat $xalign, gfloat $yalign)
  is native('gtk-3')
  is export
  { * }
