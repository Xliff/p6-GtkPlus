use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TextMark;
use GTK::Raw::Types;

class GTK::TextMark {
  has GtkTextMark $!tm;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    self.setType('GTK::TextMark');
    $o;
  }

  submethod BUILD(:$textmark) {
    $!tm = $textmark;
  }

  method new (
    Int() $left_gravity         # gboolean $left_gravity
  ) {
    my uint32 $lg = self.RESOLVE-BOOL($left_gravity);
    my $textmark = gtk_text_mark_new($!tm, $lg);
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
        Bool( gtk_text_mark_get_visible($!tm) );
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
    gtk_text_mark_get_buffer($!tm);
  }

  method get_deleted {
    gtk_text_mark_get_deleted($!tm);
  }

  method get_left_gravity {
    gtk_text_mark_get_left_gravity($!tm);
  }

  method get_name {
    gtk_text_mark_get_name($!tm);
  }

  method get_type {
    gtk_text_mark_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
