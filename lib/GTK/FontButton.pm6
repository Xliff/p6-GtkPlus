use v6.c;

use Method::Also;

use GTK::Raw::FontButton:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Button:ver<3.0.1146>;

use GTK::Roles::FontChooser:ver<3.0.1146>;

my subset GtkFontButtonAncestry is export
  where GtkFontButton | GtkFontChooser | ButtonAncestry;

constant FontButtonAncestry is export = GtkFontButtonAncestry;

class GTK::FontButton:ver<3.0.1146> is GTK::Button {
  also does GTK::Roles::FontChooser;

  has GtkFontButton $!fb is implementor;

  submethod BUILD(:$gtk-font-button) {
    self.setGtkFontButton($gtk-font-button) if $gtk-font-button;
  }

  method setGtkFontButton (GtkFontButtonAncestry $_) {
    my $to-parent;

    $!fb = do {
      when GtkFontButton {
        $to-parent = cast(GtkButton, $_);
        $_;
      }

      when GtkFontChooser {
        $!fnt-c    = $_;                            # GTK::Roles::FontChooser
        $to-parent = cast(GtkButton, $_);
        cast(GtkFontButton, $_);
      }

      when ButtonAncestry {
        $to-parent = $_;
        cast(GtkFontButton, $_);
      }
    }
    self.setGtkButton($to-parent);
    self.roleInit-GtkFontChooser;
  }

  method GTK::Raw::Definitions::GtkFontButton
    is also<GtkFontButton>
  { $!fb }

  multi method new (GtkFontButtonAncestry $gtk-font-button, :$ref = False) {
    return Nil unless $gtk-font-button;

    my $o = self.bless(:$gtk-font-button);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-font-button = gtk_font_button_new();

    $gtk-font-button ?? self.bless(:$gtk-font-button) !! Nil;
  }

  method new_with_font (Str() $font) is also<new-with-font> {
    my $gtk-font-button = gtk_font_button_new_with_font($font);

    $gtk-font-button ?? self.bless(:$gtk-font-button) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkFontButton, gpointer --> void
  method font-set is also<font_set> {
    self.connect($!fb, 'font-set');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method font_name is rw is also<font-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_button_get_font_name($!fb);
      },
      STORE => sub ($, Str() $fontname is copy) {
        gtk_font_button_set_font_name($!fb, $fontname);
      }
    );
  }

  method show_size is rw is also<show-size> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_font_button_get_show_size($!fb);
      },
      STORE => sub ($, Int() $show_size is copy) {
        my gboolean $ss = $show_size.so.Int;

        gtk_font_button_set_show_size($!fb, $ss);
      }
    );
  }

  method show_style is rw is also<show-style> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_font_button_get_show_style($!fb);
      },
      STORE => sub ($, Int() $show_style is copy) {
        my gboolean $ss = $show_style.so.Int;

        gtk_font_button_set_show_style($!fb, $ss);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_button_get_title($!fb);
      },
      STORE => sub ($, Str() $title is copy) {
        gtk_font_button_set_title($!fb, $title);
      }
    );
  }

  method use_font is rw is also<use-font> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_font_button_get_use_font($!fb);
      },
      STORE => sub ($, Int() $use_font is copy) {
        my gboolean $uf = $use_font.so.Int;

        gtk_font_button_set_use_font($!fb, $uf);
      }
    );
  }

  method use_size is rw is also<use-size> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_font_button_get_use_size($!fb);
      },
      STORE => sub ($, Int() $use_size is copy) {
        my gboolean $us = $use_size.so.Int;

        gtk_font_button_set_use_size($!fb, $us);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_font_button_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
