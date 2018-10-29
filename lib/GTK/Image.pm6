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

  method GTK::Compat::Types::GdkPixbuf {
    self.get_pixbuf;
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

  # ↓↓↓↓ PROPPERTIES ↓↓↓↓

  # Type: gchar
  method file is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!i, 'file', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!i, 'file', $gv);
      }
    );
  }

  # Type: GIcon
  method gicon is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!i, 'gicon', $gv)
        );
        nativecast(GIcon, $gv.object);
      },
      STORE => -> $, GIcon $val is copy {
        $gv.object = $val;
        self.prop_set($!i, 'gicon', $gv);
      }
    );
  }

  # Type: gchar
  method icon-name is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!i, 'icon-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!i, 'icon-name', $gv);
      }
    );
  }

  # Type: GtkIconTheme (was GtkIconSet)
  method icon-set is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!i, 'icon-set', $gv)
        );
        nativecast(GtkIconSet, $gv.object);
      },
      STORE => -> $, GtkIconTheme() $val is copy {
        $gv.object = $val;
        self.prop_set($!i, 'icon-set', $gv);
      }
    );
  }

  # Type: gint
  method icon-size is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!i, 'icon-size', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!i, 'icon-size', $gv);
      }
    );
  }

  # Type: GdkPixbuf
  method pixbuf is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!i, 'pixbuf', $gv)
        );
        nativecast(GdkPixbuf, $gv.object);
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.object = $val;
        self.prop_set($!i, 'pixbuf', $gv);
      }
    );
  }

  # Type: GdkPixbufAnimation
  method pixbuf-animation is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!i, 'pixbuf-animation', $gv)
        );
        nativecast(GdkPixbufAnimation, $gv.object);
      },
      STORE => -> $, GdkPixbufAnimation $val is copy {
        $gv.object = $val;
        self.prop_set($!i, 'pixbuf-animation', $gv);
      }
    );
  }

  # Type: gchar
  method resource is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!i, 'resource', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        $gv.string = $val;
        self.prop_set($!i, 'resource', $gv);
      }
    );
  }

  # Type: gchar
  method stock is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!i, 'stock', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!i, 'stock', $gv);
      }
    );
  }

  # Type: GtkImageType
  method storage-type is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_ENUM );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!i, 'storage-type', $gv)
        );
        GtkImageType( $gv.enum );
      },
      STORE => -> $, $val is copy {
        warn "storage-type does not allow writing"
      }
    );
  }

  # Type: CairoSurface
  method surface is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!i, 'surface', $gv)
        );
        nativecast(cairo_surface_t, $gv.pointer);
      },
      STORE => -> $, cairo_surface_t $val is copy {
        $gv.pointer = $val;
        self.prop_set($!i, 'surface', $gv);
      }
    );
  }

  # Type: gboolean
  method use-fallback is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get($!i, 'use-fallback', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!i, 'use-fallback', $gv);
      }
    );
  }
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
