use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::FontChooser;
use GTK::Raw::Types;

use GTK::Roles::Types;
use GTK::Roles::Signals;

role GTK::Roles::FontChooser {
  also does GTK::Roles::Types;
  also does GTK::Roles::Signals;

  has GtkFontChooser $!fc;

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
   # GtkFontChooser, gchar, gpointer --> void
   method font-activated {
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

  method font_desc is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_chooser_get_font_desc($!fc);
      },
      STORE => sub ($, PangoFontDescription $font_desc is copy) {
        gtk_font_chooser_set_font_desc($!fc, $font_desc);
      }
    );
  }

  method font_map is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_chooser_get_font_map($!fc);
      },
      STORE => sub ($, PangoFontMap $fontmap is copy) {
        gtk_font_chooser_set_font_map($!fc, $fontmap);
      }
    );
  }

  method preview_text is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_chooser_get_preview_text($!fc);
      },
      STORE => sub ($, Str() $text is copy) {
        gtk_font_chooser_set_preview_text($!fc, $text);
      }
    );
  }

  method show_preview_entry is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_font_chooser_get_show_preview_entry($!fc);
      },
      STORE => sub ($, Int() $show_preview_entry is copy) {
        my gboolean = $spe = self.RESOLVE-BOOL($show_preview_entry);
        gtk_font_chooser_set_show_preview_entry($!fc, $spe);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_font_face {
    gtk_font_chooser_get_font_face($!fc);
  }

  method get_font_family {
    gtk_font_chooser_get_font_family($!fc);
  }

  method get_font_size {
    gtk_font_chooser_get_font_size($!fc);
  }

  method get_type {
    gtk_font_chooser_get_type();
  }

  multi method set_filter_func (
    GtkFontFilterFunc $filter,
    gpointer $user_data,
    GDestroyNotify $destroy
  ) {
    gtk_font_chooser_set_filter_func($!fc, $filter, $user_data, $destroy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
