use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TextMark;
use GTK::Raw::Types;

use GTK::Roles::Types;

class GTK::TextMark {
  also does GTK::Roles::Types;

  has GtkTextMark $!tm;

  submethod BUILD(:$textmark) {
    $!tm = $textmark;
  }

  method new (
    Str() $name,
    Int() $left_gravity         # gboolean $left_gravity
  ) {
    my uint32 $lg = self.RESOLVE-BOOL($left_gravity);
    my $textmark = gtk_text_mark_new($name, $lg);
    self.bless(:$textmark);
  }

  method GTK::Raw::Types::GtkTextMark {
    $!tm;
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
  method get_buffer {
    GTK::TextBuffer( gtk_text_mark_get_buffer($!tm) );
  }

  method get_deleted {
    so gtk_text_mark_get_deleted($!tm);
  }

  method get_left_gravity {
    so gtk_text_mark_get_left_gravity($!tm);
  }

  method get_name {
    gtk_text_mark_get_name($!tm);
  }

  method get_type {
    gtk_text_mark_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
