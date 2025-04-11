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

  has GtkFontChooser $!fnt-c;

  method roleInit-GtkFontChooser {
    return if $!fnt-c;

    my \i = findProperImplementor(self.^attributes);

    $!fnt-c = cast( GtkFontChooser, i.get_value(self) );
  }

  method GTK::Raw::Definitions::GtkFontChooser
    is also<GtkFontChooser>
  { $!fnt-c }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
   # GtkFontChooser, gchar, gpointer --> void
   method font-activated is also<font_activated> {
     self.connect($!fnt-c, 'font-activated');
   }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method font is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_chooser_get_font($!fnt-c);
      },
      STORE => sub ($, Str() $fontname is copy) {
        gtk_font_chooser_set_font($!fnt-c, $fontname);
      }    );
  }

  method font-desc ( :$raw = False ) is rw {
    self.font_desc( :$raw );
  }
  method font_desc (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $d = gtk_font_chooser_get_font_desc($!fnt-c);

        $d ??
          ( $raw ?? $d !! Pango::FontDescription.new($d) )
          !!
          Nil;
      },
      STORE => sub ($, PangoFontDescription() $font_desc is copy) {
        gtk_font_chooser_set_font_desc($!fnt-c, $font_desc);
      }
    );
  }

  method font-map ( :$raw = False ) is rw {
    self.font_map( :$raw );
  }
  method font_map (:$raw = False) is rw is also<font-map> {
    Proxy.new(
      FETCH => sub ($) {
        my $m = gtk_font_chooser_get_font_map($!fnt-c);

        $m ??
          ( $raw ?? $m !! Pango::FontMap.new($m) )
          !!
          Nil;
      },
      STORE => sub ($, PangoFontMap() $fontmap is copy) {
        gtk_font_chooser_set_font_map($!fnt-c, $fontmap);
      }
    );
  }

  method preview_text is rw is also<preview-text> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_chooser_get_preview_text($!fnt-c);
      },
      STORE => sub ($, Str() $text is copy) {
        gtk_font_chooser_set_preview_text($!fnt-c, $text);
      }
    );
  }

  method show_preview_entry is rw is also<show-preview-entry> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_font_chooser_get_show_preview_entry($!fnt-c);
      },
      STORE => sub ($, Int() $show_preview_entry is copy) {
        my gboolean $spe = $show_preview_entry.so.Int;

        gtk_font_chooser_set_show_preview_entry($!fnt-c, $spe);
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
    my $ff = gtk_font_chooser_get_font_face($!fnt-c);

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
    my $f = gtk_font_chooser_get_font_family($!fnt-c);

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
    gtk_font_chooser_get_font_size($!fnt-c);
  }

  method get_fontchooser_type is also<get-fontchooser-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_font_chooser_get_type, $n, $t );
  }

  multi method set_filter_func (
                   &filter,
    gpointer       $user_data = Pointer,
    GDestroyNotify $destroy   = Pointer
  )
    is also<set-filter-func>
  {
    gtk_font_chooser_set_filter_func($!fnt-c, &filter, $user_data, $destroy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
