use v6.c;

use Method::Also;

use GTK::Raw::TextMark;
use GTK::Raw::Types;

use GLib::Roles::Object;
use GTK::Roles::Types;

class GTK::TextMark {
  also does GLib::Roles::Object;
  also does GTK::Roles::Types;

  has GtkTextMark $!tm is implementor;

  submethod BUILD(:$textmark) {
    self!setObject($!tm = $textmark);
  }

  submethod DESTROY {
    #self.unref;
  }

  method GTK::Raw::Definitions::GtkTextMark
    is also<
      TextMark
      GtkTextMark
    >
  { $!tm; }

  multi method new (GtkTextMark $textmark, :$ref = False) {
    my $o = self.bless(:$textmark);
    $o.upref;
    $o;
  }
  multi method new (
    Str() $name,
    Int() $left_gravity         # gboolean $left_gravity
  ) {
    my uint32 $lg = $left_gravity;
    my $textmark = gtk_text_mark_new($name, $lg);

    $textmark ?? self.bless(:$textmark) !! Nil;
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
        my gboolean $s = $setting.so.Int;

        gtk_text_mark_set_visible($!tm, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_buffer (:$raw = False)
    is also<
      get-buffer
      buffer
    >
  {
    my $b = gtk_text_mark_get_buffer($!tm);

    $b ??
      ( $raw ?? $b !! GTK::TextBuffer($b) )
      !!
      Nil;
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
