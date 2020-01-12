use v6.c;

use Method::Also;
use NativeCall;

use GDK::Pixbuf;

use GTK::Raw::Image;
use GTK::Raw::Types;

use GLib::Value;
use GTK::Widget;

our subset ImageAncestry is export where GtkImage | WidgetAncestry;

class GTK::Image is GTK::Widget {
  has GtkImage $!i is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$image) {
    my $to-parent;
    given $image {
      when ImageAncestry {
        $!i = do {
          when GtkImage {
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkImage, $_);
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

  method GDK::Raw::Definitions::GdkPixbuf
    is also<
      Pixbuf
      GdkPixbuf
    >
  { self.get_pixbuf(:raw) }

  method GTK::Raw::Definitions::GtkImage
    is also<
      Image
      GtkImage
    >
  { $!i }

  multi method new (ImageAncestry $image) {
    return Nil unless $image;
    my $o = self.bless(:$image);
    $o.upref;
    $o;
  }
  multi method new {
    my $image = gtk_image_new();

    $image ?? self.bless(:$image) !! Nil;
  }

  method new_from_animation (GdkPixbufAnimation $animation)
    is also<new-from-animation>
  {
    my $image = gtk_image_new_from_animation($animation);

    $image ?? self.bless(:$image) !! Nil;
  }

  method new_from_file (Str $file) is also<new-from-file> {
    my $image = gtk_image_new_from_file($file);

    $image ?? self.bless(:$image) !! Nil;
  }

  method new_from_gicon (
    GIcon $icon,
    Int() $size                  # GtkIconSize $size
  )
    is also<new-from-gicon>
  {
    my guint32 $s = $size;
    my $image = gtk_image_new_from_gicon($icon, $s);

    $image ?? self.bless(:$image) !! Nil;
  }

  method new_from_icon_name (
    Str $name,
    Int() $size                  # GtkIconSize $size
  )
    is also<new-from-icon-name>
  {
    my guint32 $s = $size;
    my $image = gtk_image_new_from_icon_name($name, $s);

    $image ?? self.bless(:$image) !! Nil;
  }

  method new_from_icon_set (
    GtkIconSet $set,
    Int() $size                  # GtkIconSize $size

  )
    is DEPRECATED('new_from_icon_name')
    is also<new-from-icon-set>
  {
    my guint32 $s = $size;
    my $image = gtk_image_new_from_icon_set($set, $s);

    $image ?? self.bless(:$image) !! Nil;
  }

  method new_from_pixbuf (GdkPixbuf() $pixbuf) is also<new-from-pixbuf> {
    my $image = gtk_image_new_from_pixbuf($pixbuf);

    $image ?? self.bless(:$image) !! Nil;
  }

  method new_from_resource (Str() $resource) is also<new-from-resource> {
    my $image = gtk_image_new_from_resource($resource);

    $image ?? self.bless(:$image) !! Nil;
  }

  #method new_from_stock (Str $stock_id, GtkIconSize $size) {
  #  gtk_image_new_from_stock($stock_id, $size);
  #}

  method new_from_surface (cairo_surface_t $surface)
    is also<new-from-surface>
  {
    my $image = gtk_image_new_from_surface($surface);

    $image ?? self.bless(:$image) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ PROPPERTIES ↓↓↓↓

  # Type: Str()
  method file is rw {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('file', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('file', $gv);
      }
    );
  }

  # Type: GIcon
  method gicon is rw {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gicon', $gv)
        );
        nativecast(GIcon, $gv.object);
      },
      STORE => -> $, GIcon() $val is copy {
        $gv.object = $val;
        self.prop_set('gicon', $gv);
      }
    );
  }

  # Type: Str()
  method icon-name is rw is also<icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('icon-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('icon-name', $gv);
      }
    );
  }

  # Type: GtkIconSet
  method icon-set is rw
    is DEPRECATED('GTK::Image.icon-name')
    is also<icon_set>
  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('icon-set', $gv)
        );
        nativecast(GtkIconSet, $gv.object);
      },
      STORE => -> $, GtkIconTheme() $val is copy {
        $gv.object = $val;
        self.prop_set('icon-set', $gv);
      }
    );
  }

  # Type: gint
  method icon-size is rw is also<icon_size> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('icon-size', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;

        self.prop_set('icon-size', $gv);
      }
    );
  }

  # Type: GdkPixbuf
  method pixbuf (:$raw = False) is rw {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        # $gv = GLib::Value.new(
        #   self.prop_get('pixbuf', $gv)
        # );
        # GDK::Pixbuf.new( nativecast(GdkPixbuf, $gv.object) );
        my $p = self.get_pixbuf(:$raw);

        $p ??
          ( $raw ?? $p !! GDK::Pixbuf.new($p) )
          !!
          Nil;
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.object = $val;
        self.prop_set('pixbuf', $gv);
      }
    );
  }

  # Type: GdkPixbufAnimation
  method pixbuf-animation is rw is also<pixbuf_animation> {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('pixbuf-animation', $gv)
        );
        nativecast(GdkPixbufAnimation, $gv.object);
      },
      STORE => -> $, GdkPixbufAnimation $val is copy {
        $gv.object = $val;
        self.prop_set('pixbuf-animation', $gv);
      }
    );
  }

  # Type: Str()
  method resource is rw {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('resource', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        $gv.string = $val;
        self.prop_set('resource', $gv);
      }
    );
  }

  # Type: Str()
  method stock is rw {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('stock', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('stock', $gv);
      }
    );
  }

  # Type: GtkImageType
  method storage-type is rw is also<storage_type> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('storage-type', $gv)
        );
        GtkImageTypeEnum( $gv.int );
      },
      STORE => -> $, $val is copy {
        warn 'storage-type does not allow writing';
      }
    );
  }

  # Type: CairoSurface
  method surface is rw {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('surface', $gv)
        );
        nativecast(cairo_surface_t, $gv.pointer);
      },
      STORE => -> $, cairo_surface_t $val is copy {
        $gv.pointer = $val;
        self.prop_set('surface', $gv);
      }
    );
  }

  # Type: gboolean
  method use-fallback is rw is also<use_fallback> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('use-fallback', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-fallback', $gv);
      }
    );
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method pixel_size is rw is also<pixel-size> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_image_get_pixel_size($!i);
      },
      STORE => sub ($, Int() $pixel_size is copy) {
        my gint $ps = $pixel_size;

        gtk_image_set_pixel_size($!i, $ps);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method clear {
    gtk_image_clear($!i);
  }

  method get_animation is also<get-animation> {
    gtk_image_get_animation($!i);
  }

  proto method get_gicon (|)
    is also<get-gicon>
  { * }

  multi method get_gicon {
    my GIcon $gi = GIcon.new;
    my Int $s;
    samewith($gi, $s);
    ($gi, $s);
  }
  multi method get_gicon (
    GIcon $gicon is rw,
    Int() $size is rw             # GtkIconSize $size
  ) {
    my guint32 $s = $size;
    gtk_image_get_gicon($!i, $gicon, $s);
    $size = $s;
  }

  proto method get_icon_name (|)
    is also<get-icon-name>
  { * }

  multi method get_icon_name {
    my Str $name = '';
    my Int $size = 0;
    samewith($name, $size);
  }
  multi method get_icon_name (
    Str() $icon_name is rw,
    Int() $size is rw             # GtkIconSize $size
  ) {
    my guint32 $s = $size;
    my $n = CArray[Str].new;
    $n[0] = $icon_name;
    gtk_image_get_icon_name($!i, $n, $s);
    ($icon_name, $size) = ( $n[0], GtkIconSizeEnum($s) );
  }

  proto method get_icon_set (|)
    is also<get-icon-set>
  { * }

  multi method get_icon_set {
    my GtkIconSet $is = GtkIconSet.new;
    my Int $s;
    samewith($is, $s);
    ($is, $s);
  }
  multi method get_icon_set (
    GtkIconSet $icon_set is rw,
    Int() $size is rw             # GtkIconSize $size
  ) {
    my guint32 $s = $size;
    gtk_image_get_icon_set($!i, $icon_set, $s);
  }

  method get_pixbuf (:$raw = False) is also<get-pixbuf> {
    warn "*** Pixbuf data is only valid if image type is GTK_IMAGE_EMPTY or { ''
         } GTK_IMAGE_PIXBUF";
       unless self.get-storage-type == (GTK_IMAGE_EMPTY, GTK_IMAGE_PIXBUF).any;

    my $p = gtk_image_get_pixbuf($!i);

    $p ??
      ($raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;
  }

  #method get_stock (Str() $stock_id, GtkIconSize $size) {
  #  gtk_image_get_stock($!i, $stock_id, $size);
  #}

  method get_storage_type is also<get-storage-type> {
    GtkImageTypeEnum( gtk_image_get_storage_type($!i) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_image_get_type, $n, $t );
  }

  method set_from_animation (GdkPixbufAnimation $animation)
    is also<set-from-animation>
  {
    gtk_image_set_from_animation($!i, $animation);
  }

  method set_from_file (Str() $filename) is also<set-from-file> {
    gtk_image_set_from_file($!i, $filename);
  }

  method set_from_gicon (
    GIcon() $icon,
    Int() $size                   # GtkIconSize $size
  )
    is also<set-from-gicon>
  {
    my guint32 $s = $size;

    gtk_image_set_from_gicon($!i, $icon, $s);
  }

  method set_from_icon_name (
    Str() $icon_name,
    Int() $size                   # GtkIconSize $size
  )
    is also<set-from-icon-name>
  {
    my guint32 $s = $size;

    gtk_image_set_from_icon_name($!i, $icon_name, $s);
  }

  method set_from_icon_set (
    GtkIconSet $icon_set,
    Int() $size                   # GtkIconSize $size
  )
    is also<set-from-icon-set>
  {
    my guint32 $s = $size;

    gtk_image_set_from_icon_set($!i, $icon_set, $s);
  }

  method set_from_pixbuf (GdkPixbuf() $pixbuf)
    is also<set-from-pixbuf>
  {
    gtk_image_set_from_pixbuf($!i, $pixbuf);
  }

  method set_from_resource (Str() $resource_path)
    is also<set-from-resource>
  {
    gtk_image_set_from_resource($!i, $resource_path);
  }

  method set_from_stock (
    Str() $stock_id,
    Int() $size                   # GtkIconSize $size
  )
    is also<set-from-stock>
  {
    my guint32 $s = $size;

    gtk_image_set_from_stock($!i, $stock_id, $s);
  }

  method set_from_surface (cairo_surface_t $surface)
    is also<set-from-surface>
  {
    gtk_image_set_from_surface($!i, $surface);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
