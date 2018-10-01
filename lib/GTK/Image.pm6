use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Image;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::Image is GTK::Widget {
  has GtkImage $!i;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Image');
    $o;
  }

  submethod BUILD(:$image) {
    my $to-parent;
    given $image {
      when GtkImage | GtkWidget {
        $!i = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkImage, $_);
          }
          when GtkImage {
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }
        }
        self.setWidget($to-parent);
      }
      when GTK::Image {
      }
      default {
      }
    }
  }

  multi method new {
    my $image = gtk_image_new();
    self.bless(:$image);
  }
  multi method new (GtkWidget $image) {
    self.bless(:$image);
  }

  method new_from_animation (GdkPixbufAnimation $animation) {
    my $image = gtk_image_new_from_animation($animation);
    self.bless(:$image);
  }

  method new_from_file (Str $file) {
    my $image = gtk_image_new_from_file($file);
    self.bless(:$image);
  }

  method new_from_gicon (
    GIcon $icon,
    Int() $size                  # GtkIconSize $size
  ) {
    my guint32 $s = self.RESOLVE-UINT($size);
    my $image = gtk_image_new_from_gicon($icon, $s);
    self.bless(:$image);
  }

  method new_from_icon_name (
    Str $name,
    Int() $size                  # GtkIconSize $size
  ) {
    my guint32 $s = self.RESOLVE-UINT($size);
    my $image = gtk_image_new_from_icon_name($name, $s);
    self.bless(:$image);
  }

  method new_from_icon_set (
    GtkIconSet $set,
    Int() $size                  # GtkIconSize $size

  ) {
    my guint32 $s = self.RESOLVE-UINT($size);
    my $image = gtk_image_new_from_icon_set($set, $s);
    self.bless(:$image);
  }

  method new_from_pixbuf (GdkPixbuf $pixbuf) {
    my $image = gtk_image_new_from_pixbuf($pixbuf);
    self.bless(:$image);
  }

  method new_from_resource (Str $resource) {
    my $image = gtk_image_new_from_resource($resource);
    self.bless(:$image);
  }

  #method new_from_stock (Str $stock_id, GtkIconSize $size) {
  #  gtk_image_new_from_stock($stock_id, $size);
  #}

  method new_from_surface (cairo_surface_t $surface) {
    my $image = gtk_image_new_from_surface($surface);
    self.bless(:$image);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method pixel_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_image_get_pixel_size($!i);
      },
      STORE => sub ($, Int() $pixel_size is copy) {
        my gint $ps = self.RESOLVE-INT($pixel_size);
        gtk_image_set_pixel_size($!i, $ps);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method clear {
    gtk_image_clear($!i);
  }

  method get_animation {
    gtk_image_get_animation($!i);
  }

  method get_gicon (
    GIcon $gicon,
    uint32 $size                  # GtkIconSize $size
  ) {
    my guint32 $s = self.RESOLVE-UINT($size);
    gtk_image_get_gicon($!i, $gicon, $s);
  }

  method get_icon_name (
    gchar $icon_name,
    uint32 $size                  # GtkIconSize $size
  ) {
    my guint32 $s = self.RESOLVE-UINT($size);
    gtk_image_get_icon_name($!i, $icon_name, $s);
  }

  method get_icon_set (
    GtkIconSet $icon_set,
    uint32 $size                  # GtkIconSize $size
  ) {
    my guint32 $s = self.RESOLVE-UINT($size);
    gtk_image_get_icon_set($!i, $icon_set, $s);
  }

  method get_pixbuf {
    gtk_image_get_pixbuf($!i);
  }

  #method get_stock (gchar $stock_id, GtkIconSize $size) {
  #  gtk_image_get_stock($!i, $stock_id, $size);
  #}

  method get_storage_type {
    gtk_image_get_storage_type($!i);
  }

  method get_type {
    gtk_image_get_type();
  }

  method set_from_animation (GdkPixbufAnimation $animation) {
    gtk_image_set_from_animation($!i, $animation);
  }

  method set_from_file (gchar $filename) {
    gtk_image_set_from_file($!i, $filename);
  }

  method set_from_gicon (
    GIcon $icon,
    uint32 $size                  # GtkIconSize $size
  ) {
    my guint32 $s = self.RESOLVE-UINT($size);
    gtk_image_set_from_gicon($!i, $icon, $s);
  }

  method set_from_icon_name (
    gchar $icon_name,
    uint32 $size                  # GtkIconSize $size
  ) {
    my guint32 $s = self.RESOLVE-UINT($size);
    gtk_image_set_from_icon_name($!i, $icon_name, $s);
  }

  method set_from_icon_set (
    GtkIconSet $icon_set,
    uint32 $size                  # GtkIconSize $size
  ) {
    my guint32 $s = self.RESOLVE-UINT($size);
    gtk_image_set_from_icon_set($!i, $icon_set, $s);
  }

  method set_from_pixbuf (GdkPixbuf $pixbuf) {
    gtk_image_set_from_pixbuf($!i, $pixbuf);
  }

  method set_from_resource (gchar $resource_path) {
    gtk_image_set_from_resource($!i, $resource_path);
  }

  method set_from_stock (
    gchar $stock_id,
    uint32 $size                  # GtkIconSize $size
  ) {
    gtk_image_set_from_stock($!i, $stock_id, $size);
  }

  method set_from_surface (cairo_surface_t $surface) {
    gtk_image_set_from_surface($!i, $surface);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
