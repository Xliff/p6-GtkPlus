use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::FontChooser:ver<3.0.1146>;

use Pango::FontFace;
use Pango::FontFamily;
use Pango::FontDescription;

use GTK::Roles::Signals::Generic:ver<3.0.1146>;

role GTK::Roles::FontChooser:ver<3.0.1146> {
  also does GTK::Roles::Signals::Generic;

  has GtkFontChooser $!fc;

  method GTK::Raw::Definitions::GtkFontChooser
    is also<GtkFontChooser>
  { $!fc }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
   # GtkFontChooser, gchar, gpointer --> void
   method font-activated is also<font_activated> {
     self.connect($!fc, 'font-activated');
   }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method font is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_chooser_get_font($!fc);
      },
      STORE => sub ($, Str() $fontname is copy) {
        gtk_font_chooser_set_font($!fc, $fontname);
      }
    );
  }

  method font_desc (:$raw = False) is rw is also<font-desc> {
    Proxy.new(
      FETCH => sub ($) {
        my $d = gtk_font_chooser_get_font_desc($!fc);

        $d ??
          ( $raw ?? $d !! Pango::FontDescription.new($d) )
          !!
          Nil;
      },
      STORE => sub ($, PangoFontDescription() $font_desc is copy) {
        gtk_font_chooser_set_font_desc($!fc, $font_desc);
      }
    );
  }

  method font_map (:$raw = False) is rw is also<font-map> {
    Proxy.new(
      FETCH => sub ($) {
        my $m = gtk_font_chooser_get_font_map($!fc);

        $m ??
          ( $raw ?? $m !! Pango::FontMap.new($m) )
          !!
          Nil;
      },
      STORE => sub ($, PangoFontMap() $fontmap is copy) {
        gtk_font_chooser_set_font_map($!fc, $fontmap);
      }
    );
  }

  method preview_text is rw is also<preview-text> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_chooser_get_preview_text($!fc);
      },
      STORE => sub ($, Str() $text is copy) {
        gtk_font_chooser_set_preview_text($!fc, $text);
      }
    );
  }

  method show_preview_entry is rw is also<show-preview-entry> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_font_chooser_get_show_preview_entry($!fc);
      },
      STORE => sub ($, Int() $show_preview_entry is copy) {
        my gboolean $spe = $show_preview_entry.so.Int;

        gtk_font_chooser_set_show_preview_entry($!fc, $spe);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_font_face ( :$raw = False )
    is also<
      get-font-face
      font_face
      font-face
    >
  {
    my $ff = gtk_font_chooser_get_font_face($!fc);

    $ff ??
      ( $raw ?? $ff !! Pango::FontFace.new($ff) )
      !!
      Nil;
  }

  method get_font_family ( :$raw = False )
    is also<
      get-font-family
      font_family
      font-family
    >
  {
    my $f = gtk_font_chooser_get_font_family($!fc);

    $f ??
      ( $raw ?? $f !! Pango::FontFamily.new($f, :!ref) )
      !!
      Nil;
  }

  method get_font_size
    is also<
      get-font-size
      font_size
      font-size
    >
  {
    gtk_font_chooser_get_font_size($!fc);
  }

  method get_fontchooser_type is also<get-fontchooser-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_font_chooser_get_type, $n, $t );
  }

  multi method set_filter_func (
    &filter,
    gpointer $user_data     = Pointer,
    GDestroyNotify $destroy = Pointer
  )
    is also<set-filter-func>
  {
    gtk_font_chooser_set_filter_func($!fc, &filter, $user_data, $destroy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
