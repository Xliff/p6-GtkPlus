use v6.c;

use NativeCall;

use GTK::Compat::Types;
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

# GtkIconSize $size
sub gtk_button_new_from_icon_name (gchar $icon_name, uint32 $size)
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

# --> GtkPositionType
sub gtk_button_get_image_position (GtkButton $button)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_button_get_use_stock (GtkButton $button)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_button_get_label (GtkButton $button)
  returns Str
  is native('gtk-3')
  is export
  { * }

sub gtk_button_get_image (GtkButton $button)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_button_get_use_underline (GtkButton $button)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_button_get_always_show_image (GtkButton $button)
  returns uint32
  is native('gtk-3')
  is export
  { * }

# --> GtkReliefstyle
sub gtk_button_get_relief (GtkButton $button)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_button_get_focus_on_click (GtkButton $button)
  returns uint32
  is native('gtk-3')
  is export
  { * }

# GtkPositionType $position
sub gtk_button_set_image_position (GtkButton $button, uint32 $position)
  is native('gtk-3')
  is export
  { * }

sub gtk_button_set_use_stock (GtkButton $button, gboolean $use_stock)
  is native('gtk-3')
  is export
  { * }

sub gtk_button_set_label (GtkButton $button, gchar $label)
  is native('gtk-3')
  is export
  { * }

sub gtk_button_set_image (GtkButton $button, GtkWidget $image)
  is native('gtk-3')
  is export
  { * }

sub gtk_button_set_use_underline (GtkButton $button, gboolean $use_underline)
  is native('gtk-3')
  is export
  { * }

sub gtk_button_set_always_show_image (GtkButton $button, gboolean $always_show)
  is native('gtk-3')
  is export
  { * }

# GtkReliefStyle $relief
sub gtk_button_set_relief (GtkButton $button, uint32 $relief)
  is native('gtk-3')
  is export
  { * }

sub gtk_button_set_focus_on_click (GtkButton $button, gboolean $focus_on_click)
  is native('gtk-3')
  is export
  { * }
