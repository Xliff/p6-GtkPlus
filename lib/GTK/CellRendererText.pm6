use v6.c;

use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Raw::CellRendererText;
use GTK::Raw::Types;

use GTK::CellRenderer;

class GTK::CellRendererText is GTK::CellRenderer {
  has GtkCellRendererText $!crt;

  submethod BUILD(:$celltext) {
    given $celltext {
      when GtkCellRendererText | GtkCellRenderer {
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
      when GtkCellRenderer {
        $to-parent = $_;
        nativecast(GtkCellRendererText, $_);
      }
      when GtkCellRendererText  {
        $to-parent = nativecast(GtkCellRenderer, $_);
        $_;
      }
    }
    self.setCellRenderer($to-parent);
  }

  method GTK::Raw::Types::CellRendererText {
    $!crt;
  }

  multi method new {
    my $celltext = gtk_cell_renderer_text_new();
    self.bless(:$celltext);
  }
  multi method new (GtkCellRenderer $celltext) {
    self.bless(:$celltext);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCellRendererText, gchar, gchar, gpointer --> void
  method edited {
    self.connect($!crt, 'edited');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method align-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'align-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'align-set', $gv);
      }
    );
  }

  # Type: PangoAlignment
  method alignment is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'alignment', $gv);
        PangoAlignment( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set($!crt, 'alignment', $gv);
      }
    );
  }

  # Type: PangoAttrList
  method attributes is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_POINTER);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'attributes', $gv);
        nativecast(PangoAttrList, $gv.pointer);
      },
      STORE => -> $, PangoAttrList $val is copy {
        $gv.pointer = $val;
        self.prop_set($!crt, 'attributes', $gv);
      }
    );
  }

  # Type: gchar
  method background is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        warn "background does not allow reading"
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!crt, 'background', $gv);
      }
    );
  }

  # Type: GdkColor
  method background-gdk is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_POINTER);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'background-gdk', $gv);
        nativecast(GdkColor, $gv.pointer);
      },
      STORE => -> $, GdkColor $val is copy {
        $gv.pointer = $val;
        self.prop_set($!crt, 'background-gdk', $gv);
      }
    );
  }

  # Type: GdkRGBA
  method background-rgba is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_POINTER);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'background-rgba', $gv);
        nativecast(GTK::Compat::RGBA, $gv.pointer);
      },
      STORE => -> $, GTK::Compat::RGBA $val is copy {
        $gv.pointer = nativecast(Pointer, $val);
        self.prop_set($!crt, 'background-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method background-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'background-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'background-set', $gv);
      }
    );
  }

  # Type: gboolean
  method editable is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'editable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'editable', $gv);
      }
    );
  }

  # Type: gboolean
  method editable-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'editable-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'editable-set', $gv);
      }
    );
  }

  # Type: PangoEllipsizeMode
  method ellipsize is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'ellipsize', $gv);
        PangoEllipsizeMode( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-INT($val);
        self.prop_set($!crt, 'ellipsize', $gv);
      }
    );
  }

  # Type: gboolean
  method ellipsize-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'ellipsize-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'ellipsize-set', $gv);
      }
    );
  }

  # Type: gchar
  method family is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'family', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!crt, 'family', $gv);
      }
    );
  }

  # Type: gboolean
  method family-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'family-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set($!crt, 'family-set', $gv);
      }
    );
  }

  # Type: gchar
  method font is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'font', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!crt, 'font', $gv);
      }
    );
  }

  # Type: PangoFontDescription
  method font-desc is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'font-desc', $gv);
        PangoFontDescription( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set($!crt, 'font-desc', $gv);
      }
    );
  }

  # Type: gchar
  method foreground is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        warn "foreground does not allow reading"
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!crt, 'foreground', $gv);
      }
    );
  }

  # Type: GdkColor
  method foreground-gdk is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_POINTER);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'foreground-gdk', $gv);
        $gv.pointer;
      },
      STORE => -> $, GdkColor $val is copy {
        $gv.pointer = $val;
        self.prop_set($!crt, 'foreground-gdk', $gv);
      }
    );
  }

  # Type: GdkRGBA
  method foreground-rgba is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_POINTER);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'foreground-rgba', $gv);
        nativecast(GTK::Compat::RGBA, $gv.pointer);
      },
      STORE => -> $, GTK::Compat::RGBA $val is copy {
        $gv.pointer = nativecast(Pointer, $val);
        self.prop_set($!crt, 'foreground-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method foreground-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'foreground-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'foreground-set', $gv);
      }
    );
  }

  # Type: gchar
  method language is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'language', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!crt, 'language', $gv);
      }
    );
  }

  # Type: gboolean
  method language-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'language-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'language-set', $gv);
      }
    );
  }

  # Type: gchar
  method markup is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        warn "markup does not allow reading"
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!crt, 'markup', $gv);
      }
    );
  }

  # Type: gint
  method max-width-chars is rw {
    my GTK::Compat::Value $gv .= new;
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'max-width-chars', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!crt, 'max-width-chars', $gv);
      }
    );
  }

  # Type: gchar
  method placeholder-text is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'placeholder-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!crt, 'placeholder-text', $gv);
      }
    );
  }

  # Type: gint
  method rise is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'rise', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!crt, 'rise', $gv);
      }
    );
  }

  # Type: gboolean
  method rise-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'rise-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'rise-set', $gv);
      }
    );
  }

  # Type: gdouble
  method scale is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_DOUBLE);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'scale', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set($!crt, 'scale', $gv);
      }
    );
  }

  # Type: gboolean
  method scale-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'scale-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'scale-set', $gv);
      }
    );
  }

  # Type: gboolean
  method single-paragraph-mode is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'single-paragraph-mode', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'single-paragraph-mode', $gv);
      }
    );
  }

  # Type: gint
  method size is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'size', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!crt, 'size', $gv);
      }
    );
  }

  # Type: gdouble
  method size-points is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_DOUBLE);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'size-points', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set($!crt, 'size-points', $gv);
      }
    );
  }

  # Type: gboolean
  method size-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'size-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'size-set', $gv);
      }
    );
  }

  # Type: PangoStretch
  method stretch is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'stretch', $gv);
        PangoStretch( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set($!crt, 'stretch', $gv);
      }
    );
  }

  # Type: gboolean
  method stretch-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'stretch-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'stretch-set', $gv);
      }
    );
  }

  # Type: gboolean
  method strikethrough is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'strikethrough', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'strikethrough', $gv);
      }
    );
  }

  # Type: gboolean
  method strikethrough-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'strikethrough-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'strikethrough-set', $gv);
      }
    );
  }

  # Type: PangoStyle
  method style is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'style', $gv);
        PangoStyle( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set($!crt, 'style', $gv);
      }
    );
  }

  # Type: gboolean
  method style-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'style-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'style-set', $gv);
      }
    );
  }

  # Type: gchar
  method text is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_STRING);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set($!crt, 'text', $gv);
      }
    );
  }

  # Type: PangoUnderline
  method underline is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'underline', $gv);
        PangoUnderline( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set($!crt, 'underline', $gv);
      }
    );
  }

  # Type: gboolean
  method underline-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'underline-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'underline-set', $gv);
      }
    );
  }

  # Type: PangoVariant
  method variant is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'variant', $gv);
        PangoVariant( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set($!crt, 'variant', $gv);
      }
    );
  }

  # Type: gboolean
  method variant-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'variant-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOLEAN($val);
        self.prop_set($!crt, 'variant-set', $gv);
      }
    );
  }

  # Type: gint
  method weight is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'weight', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!crt, 'weight', $gv);
      }
    );
  }

  # Type: gboolean
  method weight-set is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'weight-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set($!crt, 'weight-set', $gv);
      }
    );
  }

  # Type: gint
  method width-chars is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'width-chars', $gv);
        $gv.int
      },
      STORE => -> $, Int() $val is copy {
        $gv.int =  self.RESOLVE-INT($val);
        self.prop_set($!crt, 'width-chars', $gv);
      }
    );
  }

  # Type: PangoWrapMode
  method wrap-mode is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_ENUM);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'wrap-mode', $gv);
        PangoWrapMode( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.enum = self.RESOLVE-UINT($val);
        self.prop_set($!crt, 'wrap-mode', $gv);
      }
    );
  }

  # Type: gint
  method wrap-width is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        self.prop_get($!crt, 'wrap-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set($!crt, 'wrap-width', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_cell_renderer_text_get_type();
  }

  method set_fixed_height_from_font (Int() $number_of_rows) {
    my gint $nr = self.RESOLVE-INT($number_of_rows);
    gtk_cell_renderer_text_set_fixed_height_from_font($!crt, $nr);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
