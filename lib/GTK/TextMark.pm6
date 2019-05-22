use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TextMark;
use GTK::Raw::Types;

use GTK::Compat::Roles::Object;
use GTK::Roles::Types;

class GTK::TextMark {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Types;

  has GtkTextMark $!tm;

  submethod BUILD(:$textmark) {
    self!setObject($!tm = $textmark);
  }

  method GTK::Raw::Types::GtkTextMark
    is also<TextMark>
  { $!tm; }

  multi method new (GtkTextMark $textmark) {
    my $o = self.bless(:$textmark);
    $o.upref;
    $o;
  }
  multi method new (
    Str() $name,
    Int() $left_gravity         # gboolean $left_gravity
  ) {
    my uint32 $lg = self.RESOLVE-BOOL($left_gravity);
    my $textmark = gtk_text_mark_new($name, $lg);
    self.bless(:$textmark);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_text_mark_get_visible($!tm);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_text_mark_set_visible($!tm, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_buffer
    is also<
      get-buffer
      buffer
    >
  {
    GTK::TextBuffer( gtk_text_mark_get_buffer($!tm) );
  }

  method get_deleted
    is also<
      get-deleted
      deleted
    >
  {
    so gtk_text_mark_get_deleted($!tm);
  }

  method get_left_gravity
    is also<
      get-left-gravity
      left_gravity
      left-gravity
    >
  {
    so gtk_text_mark_get_left_gravity($!tm);
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    gtk_text_mark_get_name($!tm);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &gtk_text_mark_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
