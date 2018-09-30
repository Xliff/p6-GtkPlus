use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TextTag;
use GTK::Raw::Types;

use GTK::Roles::Types;

class GTK::TextTag  {
  also does GTK::Roles::Types;
  
  has GtkTextTag $!tt;

  submethod BUILD(:$tag) {
    $!tt = $tag;
  }

  method new(Str() $name) {
    my $tag = gtk_text_tag_new($name);
    self.bless(:$tag);
  }

  method GTK::Raw::Types::GtkTextTag {
    $!tt;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTextTag, GObject, GdkEvent, GtkTextIter, gpointer --> gboolean
  # - Made multi so as to not conflict with the method implementing
  #   gtk_text_tag_event
  multi method event {
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
        my gint $p = self.RESOLVE-INT($priority);
        gtk_text_tag_set_priority($!tt, $p);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method changed (Int() $size_changed) {
    my gboolean $sc = self.RESOLVE-BOOL($size_changed);
    gtk_text_tag_changed($!tt, $sc);
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
