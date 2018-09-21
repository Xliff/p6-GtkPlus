use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TextTag;
use GTK::Raw::Types;

class GTK::  {
  has GtkTextTag $!tt;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    self.setType('GTK::TextTag');
    $o;
  }

  submethod BUILD(:$tag) {
    $!tt = $tag;
  }

  method new {
    my $tag = gtk_text_tag_new();
    self.bless(:$tag);
  }

  method GtkTextTag {
    $!tt;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTextTag, GObject, GdkEvent, GtkTextIter, gpointer --> gboolean
  method event {
    self.connect($!tt, 'event');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method priority is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_tag_get_priority($!tt);
      },
      STORE => sub ($, Int() $priority is copy) {
        my gint $p = $priority
        gtk_text_tag_set_priority($!tt, $p);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method changed (gboolean $size_changed) {
    gtk_text_tag_changed($!tt, $size_changed);
  }

  multi method event (
    GObject $event_object,
    GdkEvent $event,
    GtkTextIter $iter
  ) {
    gtk_text_tag_event($!tt, $event_object, $event, $iter);
  }

  method get_type {
    gtk_text_tag_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
