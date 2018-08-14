use v6.c;

use GTK::Compat::Types;
use GTK::Raw::Image;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::Image is GTK::Widget {
  has GtkImage $!i;

  submethod BUILD(:$image) {
    given $image {
      when GtkImage | GtkWidget {
        self.setParent( $!i = $image );
      }
      when GTK::Image {
      }
      default {
      }
    }
  }

  method new () {
    my $image = gtk_image_new();
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

  method new_from_gicon (GIcon $icon, GtkIconSize $size) {
    my $image = gtk_image_new_from_gicon($icon, $size);
    self.bless(:$image);
  }

  method new_from_icon_name (Str $name, GtkIconSize $size) {
    my $image = gtk_image_new_from_icon_name($name, $size);
    self.bless(:$image);
  }

  method new_from_icon_set (GtkIconSet $set, GtkIconSize $size) {
    my $image = gtk_image_new_from_icon_set($set, $size);
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
      STORE => sub ($, $pixel_size is copy) {
        gtk_image_set_pixel_size($!i, $pixel_size);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method clear () {
    gtk_image_clear($!i);
  }

  method get_animation () {
    gtk_image_get_animation($!i);
  }

  method get_gicon (GIcon $gicon, GtkIconSize $size) {
    gtk_image_get_gicon($!i, $gicon, $size);
  }

  method get_icon_name (gchar $icon_name, GtkIconSize $size) {
    gtk_image_get_icon_name($!i, $icon_name, $size);
  }

  method get_icon_set (GtkIconSet $icon_set, GtkIconSize $size) {
    gtk_image_get_icon_set($!i, $icon_set, $size);
  }

  method get_pixbuf () {
    gtk_image_get_pixbuf($!i);
  }

  #method get_stock (gchar $stock_id, GtkIconSize $size) {
  #  gtk_image_get_stock($!i, $stock_id, $size);
  #}

  method get_storage_type () {
    gtk_image_get_storage_type($!i);
  }

  method get_type () {
    gtk_image_get_type();
  }

  method set_from_animation (GdkPixbufAnimation $animation) {
    gtk_image_set_from_animation($!i, $animation);
  }

  method set_from_file (gchar $filename) {
    gtk_image_set_from_file($!i, $filename);
  }

  method set_from_gicon (GIcon $icon, GtkIconSize $size) {
    gtk_image_set_from_gicon($!i, $icon, $size);
  }

  method set_from_icon_name (gchar $icon_name, GtkIconSize $size) {
    gtk_image_set_from_icon_name($!i, $icon_name, $size);
  }

  method set_from_icon_set (GtkIconSet $icon_set, GtkIconSize $size) {
    gtk_image_set_from_icon_set($!i, $icon_set, $size);
  }

  method set_from_pixbuf (GdkPixbuf $pixbuf) {
    gtk_image_set_from_pixbuf($!i, $pixbuf);
  }

  method set_from_resource (gchar $resource_path) {
    gtk_image_set_from_resource($!i, $resource_path);
  }

  method set_from_stock (gchar $stock_id, GtkIconSize $size) {
    gtk_image_set_from_stock($!i, $stock_id, $size);
  }

  method set_from_surface (cairo_surface_t $surface) {
    gtk_image_set_from_surface($!i, $surface);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
