use v6.c;

use Method::Also;

use GDK::RGBA;

use GTK::Raw::Types;
use GTK::Raw::CellRendererText;

use Pango::AttrList;
use GLib::Value;
use GTK::CellRenderer;

use GTK::Roles::Signals::Generic;

our subset CellRendererTextAncestry is export
  where GtkCellRendererText | GtkCellRenderer;

class GTK::CellRendererText is GTK::CellRenderer {
  also does GTK::Roles::Signals::Generic;

  has GtkCellRendererText $!crt is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$celltext) {
    given $celltext {
      when CellRendererTextAncestry {
        self.setCellRendererText($celltext);
      }
      when GTK::CellRendererText {
      }
      default {
      }
    }
  }

  method setCellRendererText($celltext) {
    my $to-parent;
    $!crt = do given $celltext {
      when GtkCellRendererText  {
        $to-parent = cast(GtkCellRenderer, $_);
        $_;
      }
      default {
        $to-parent = $_;
        cast(GtkCellRendererText, $_);
      }
    }
    self.setCellRenderer($to-parent);
  }

  submethod DESTROY {
    self.disconnect-cellrenderer-signals;
  }

  method GTK::Raw::Definitions::GtkCellRendererText
    is also<
      CellRendererText
      GtkCellRendererText
    >
  { $!crt }

  multi method new (CellRendererTextAncestry $celltext) {
    $celltext ?? self.bless(:$celltext) !! Nil;
  }
  multi method new {
    my $celltext = gtk_cell_renderer_text_new();

    $celltext ?? self.bless(:$celltext) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCellRendererText, gchar, gchar, gpointer --> void
  method edited {
    self.connect-strstr($!crt, 'edited');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method align-set is rw is also<align_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('align-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('align-set', $gv);
      }
    );
  }

  # Type: PangoAlignment
  method alignment is rw {
    my GLib::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('alignment', $gv);
        PangoAlignmentEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = $val;
        self.prop_set('alignment', $gv);
      }
    );
  }

  # Type: PangoAttrList
  method attributes (:$raw = False) is rw {
    my GLib::Value $gv .= new(G_TYPE_POINTER);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('attributes', $gv);

        my $v = $gv.pointer;

        return Nil unless $v;

        $v = cast(PangoAttrList, $gv.pointer);
        $raw ?? $v !! Pango::AttrList.new($v);
      },
      STORE => -> $, PangoAttrList $val is copy {
        $gv.pointer = $val;
        self.prop_set('attributes', $gv);
      }
    );
  }

  # Type: gchar
  method background is rw {
    my GLib::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        warn "background does not allow reading"
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('background', $gv);
      }
    );
  }

  # Type: GdkColor
  method background-gdk is rw is also<background_gdk> {
    my GLib::Value $gv .= new(G_TYPE_POINTER);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('background-gdk', $gv);
        cast(GdkColor, $gv.pointer);
      },
      STORE => -> $, GdkColor $val is copy {
        $gv.pointer = $val;
        self.prop_set('background-gdk', $gv);
      }
    );
  }

  # Type: GdkRGBA
  method background-rgba is rw is also<background_rgba> {
    my GLib::Value $gv .= new(G_TYPE_POINTER);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('background-rgba', $gv);
        cast(GDK::RGBA, $gv.pointer);
      },
      STORE => -> $, GDK::RGBA $val is copy {
        $gv.pointer = cast(gpointer, $val);
        self.prop_set('background-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method background-set is rw is also<background_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('background-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('background-set', $gv);
      }
    );
  }

  # Type: gboolean
  method editable is rw {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('editable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('editable', $gv);
      }
    );
  }

  # Type: gboolean
  method editable-set is rw is also<editable_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('editable-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('editable-set', $gv);
      }
    );
  }

  # Type: PangoEllipsizeMode
  method ellipsize is rw {
    my GLib::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('ellipsize', $gv);
        PangoEllipsizeMode( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = $val;
        self.prop_set('ellipsize', $gv);
      }
    );
  }

  # Type: gboolean
  method ellipsize-set is rw is also<ellipsize_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('ellipsize-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('ellipsize-set', $gv);
      }
    );
  }

  # Type: gchar
  method family is rw {
    my GLib::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('family', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('family', $gv);
      }
    );
  }

  # Type: gboolean
  method family-set is rw is also<family_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('family-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('family-set', $gv);
      }
    );
  }

  # Type: gchar
  method font is rw {
    my GLib::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('font', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('font', $gv);
      }
    );
  }

  # Type: PangoFontDescription
  method font-desc (:$raw = False) is rw is also<font_desc> {
    my GLib::Value $gv .= new( Pango::FontDescription.get_type );
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('font-desc', $gv);

        return Nil unless $gv.boxed;

        my $fd = cast(PangoFontDescription, $gv.boxed);

        $raw ?? $fd !! Pango::FontDescription.new($fd);
      },
      STORE => -> $, PangoFontDescription() $val is copy {
        $gv.boxed = $val;
        self.prop_set('font-desc', $gv);
      }
    );
  }

  # Type: gchar
  method foreground is rw {
    my GLib::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        warn "foreground does not allow reading"
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('foreground', $gv);
      }
    );
  }

  # Type: GdkColor
  method foreground-gdk is rw is also<foreground_gdk> {
    my GLib::Value $gv .= new(G_TYPE_POINTER);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('foreground-gdk', $gv);
        $gv.pointer;
      },
      STORE => -> $, GdkColor() $val is copy {
        $gv.pointer = $val;
        self.prop_set('foreground-gdk', $gv);
      }
    );
  }

  # Type: GdkRGBA
  method foreground-rgba is rw is also<foreground_rgba> {
    my GLib::Value $gv .= new(G_TYPE_POINTER);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('foreground-rgba', $gv);
        cast(GDK::RGBA, $gv.pointer);
      },
      STORE => -> $, GDK::RGBA $val is copy {
        $gv.pointer = cast(gpointer, $val);
        self.prop_set('foreground-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method foreground-set is rw is also<foreground_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('foreground-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('foreground-set', $gv);
      }
    );
  }

  # Type: gchar
  method language is rw {
    my GLib::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('language', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('language', $gv);
      }
    );
  }

  # Type: gboolean
  method language-set is rw is also<language_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('language-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('language-set', $gv);
      }
    );
  }

  # Type: gchar
  method markup is rw {
    my GLib::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        warn "markup does not allow reading"
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('markup', $gv);
      }
    );
  }

  # Type: gint
  method max-width-chars is rw is also<max_width_chars> {
    my GLib::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('max-width-chars', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('max-width-chars', $gv);
      }
    );
  }

  # Type: gchar
  method placeholder-text is rw is also<placeholder_text> {
    my GLib::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('placeholder-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('placeholder-text', $gv);
      }
    );
  }

  # Type: gint
  method rise is rw {
    my GLib::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('rise', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('rise', $gv);
      }
    );
  }

  # Type: gboolean
  method rise-set is rw is also<rise_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('rise-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('rise-set', $gv);
      }
    );
  }

  # Type: gdouble
  method scale is rw {
    my GLib::Value $gv .= new(G_TYPE_DOUBLE);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('scale', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('scale', $gv);
      }
    );
  }

  # Type: gboolean
  method scale-set is rw is also<scale_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('scale-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('scale-set', $gv);
      }
    );
  }

  # Type: gboolean
  method single-paragraph-mode is rw is also<single_paragraph_mode> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('single-paragraph-mode', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('single-paragraph-mode', $gv);
      }
    );
  }

  # Type: gint
  method size is rw {
    my GLib::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('size', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('size', $gv);
      }
    );
  }

  # Type: gdouble
  method size-points is rw is also<size_points> {
    my GLib::Value $gv .= new(G_TYPE_DOUBLE);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('size-points', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('size-points', $gv);
      }
    );
  }

  # Type: gboolean
  method size-set is rw is also<size_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('size-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('size-set', $gv);
      }
    );
  }

  # Type: PangoStretch
  method stretch is rw {
    my GLib::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('stretch', $gv);
        PangoStretchEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = $val;
        self.prop_set('stretch', $gv);
      }
    );
  }

  # Type: gboolean
  method stretch-set is rw is also<stretch_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('stretch-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('stretch-set', $gv);
      }
    );
  }

  # Type: gboolean
  method strikethrough is rw {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('strikethrough', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('strikethrough', $gv);
      }
    );
  }

  # Type: gboolean
  method strikethrough-set is rw is also<strikethrough_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('strikethrough-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('strikethrough-set', $gv);
      }
    );
  }

  # Type: PangoStyle
  method style is rw {
    my GLib::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('style', $gv);
        PangoStyleEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = $val;
        self.prop_set('style', $gv);
      }
    );
  }

  # Type: gboolean
  method style-set is rw is also<style_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('style-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('style-set', $gv);
      }
    );
  }

  # Type: gchar
  method text is rw {
    my GLib::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  # Type: PangoUnderline
  method underline is rw {
    my GLib::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('underline', $gv);
        PangoUnderlineEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = $val;
        self.prop_set('underline', $gv);
      }
    );
  }

  # Type: gboolean
  method underline-set is rw is also<underline_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('underline-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('underline-set', $gv);
      }
    );
  }

  # Type: PangoVariant
  method variant is rw {
    my GLib::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('variant', $gv);
        PangoVariantEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = $val;
        self.prop_set('variant', $gv);
      }
    );
  }

  # Type: gboolean
  method variant-set is rw is also<variant_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('variant-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('variant-set', $gv);
      }
    );
  }

  # Type: gint
  method weight is rw {
    my GLib::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('weight', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('weight', $gv);
      }
    );
  }

  # Type: gboolean
  method weight-set is rw is also<weight_set> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('weight-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('weight-set', $gv);
      }
    );
  }

  # Type: gint
  method width-chars is rw is also<width_chars> {
    my GLib::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('width-chars', $gv);
        $gv.int
      },
      STORE => -> $, Int() $val is copy {
        $gv.int =  $val;
        self.prop_set('width-chars', $gv);
      }
    );
  }

  # Type: PangoWrapMode
  method wrap-mode is rw is also<wrap_mode> {
    my GLib::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('wrap-mode', $gv);
        PangoWrapModeEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = $val;
        self.prop_set('wrap-mode', $gv);
      }
    );
  }

  # Type: gint
  method wrap-width is rw is also<wrap_width> {
    my GLib::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get('wrap-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('wrap-width', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_cell_renderer_text_get_type, $n, $t );
  }

  method set_fixed_height_from_font (Int() $number_of_rows)
    is also<set-fixed-height-from-font>
  {
    my gint $nr = $number_of_rows;

    gtk_cell_renderer_text_set_fixed_height_from_font($!crt, $nr);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
