use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Image;

sub gtk_image_clear (GtkImage $image)
  is native(gtk)
  is export
  { * }

sub gtk_image_get_animation (GtkImage $image)
  returns GdkPixbufAnimation
  is native(gtk)
  is export
  { * }

#(GtkImage $image, GIcon $gicon, GtkIconSize $size)
sub gtk_image_get_gicon (GtkImage $image, GIcon $gicon, uint32 $size)
  is native(gtk)
  is export
  { * }

#(GtkImage $image, gchar $icon_name, GtkIconSize $size)
sub gtk_image_get_icon_name (GtkImage $image, gchar $icon_name, uint32 $size)
  is native(gtk)
  is export
  { * }

#(GtkImage $image, GtkIconSet $icon_set, GtkIconSize $size)
sub gtk_image_get_icon_set (GtkImage $image, GtkIconSet $icon_set, uint32 $size)
  is native(gtk)
  is export
  { * }

sub gtk_image_get_pixbuf (GtkImage $image)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

# (GtkImage $image, gchar $stock_id, GtkIconSize $size)
sub gtk_image_get_stock (GtkImage $image, gchar $stock_id, uint32 $size)
  is native(gtk)
  is export
  { * }

sub gtk_image_get_storage_type (GtkImage $image)
  returns uint32 # GtkImageType
  is native(gtk)
  is export
  { * }

sub gtk_image_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_image_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_image_new_from_animation (GdkPixbufAnimation $animation)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_image_new_from_file (gchar $filename)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

# (GIcon $icon, GtkIconSize $size)
sub gtk_image_new_from_gicon (GIcon $icon, uint32 $size)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

# (gchar $icon_name, GtkIconSize $size)
sub gtk_image_new_from_icon_name (gchar $icon_name, uint32 $size)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

# (GtkIconSet $icon_set, GtkIconSize $size)
sub gtk_image_new_from_icon_set (GtkIconSet $icon_set, uint32 $size)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_image_new_from_pixbuf (GdkPixbuf $pixbuf)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_image_new_from_resource (gchar $resource_path)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

# (gchar $stock_id, GtkIconSize $size)
sub gtk_image_new_from_stock (gchar $stock_id, uint32 $size)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_image_new_from_surface (cairo_surface_t $surface)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_image_set_from_animation (GtkImage $image, GdkPixbufAnimation $animation)
  is native(gtk)
  is export
  { * }

sub gtk_image_set_from_file (GtkImage $image, gchar $filename)
  is native(gtk)
  is export
  { * }

# (GtkImage $image, GIcon $icon, GtkIconSize $size)
sub gtk_image_set_from_gicon (GtkImage $image, GIcon $icon, uint32 $size)
  is native(gtk)
  is export
  { * }

# (GtkImage $image, gchar $icon_name, GtkIconSize $size)
sub gtk_image_set_from_icon_name (GtkImage $image, gchar $icon_name, uint32 $size)
  is native(gtk)
  is export
  { * }

# (GtkImage $image, GtkIconSet $icon_set, GtkIconSize $size)
sub gtk_image_set_from_icon_set (GtkImage $image, GtkIconSet $icon_set, uint32 $size)
  is native(gtk)
  is export
  { * }

sub gtk_image_set_from_pixbuf (GtkImage $image, GdkPixbuf $pixbuf)
  is native(gtk)
  is export
  { * }

sub gtk_image_set_from_resource (GtkImage $image, gchar $resource_path)
  is native(gtk)
  is export
  { * }

# (GtkImage $image, gchar $stock_id, GtkIconSize $size)
sub gtk_image_set_from_stock (GtkImage $image, gchar $stock_id, uint32 $size)
  is native(gtk)
  is export
  { * }

sub gtk_image_set_from_surface (GtkImage $image, cairo_surface_t $surface)
  is native(gtk)
  is export
  { * }

sub gtk_image_get_pixel_size (GtkImage $image)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_image_set_pixel_size (GtkImage $image, gint $pixel_size)
  is native(gtk)
  is export
  { * }