use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Frame;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::Frame is GTK::Bin {
  has GtkFrame $!f;

  submethod BUILD(:$frame) {
    given $frame {
      when GtkFrame | GtkWidget {
        $!f = do {
          when GtkWidget { nativecast(GtkFrame, $frame); }
          when GtkFrame  { $frame; }
        };
        self.setBin($frame);
      }
      when GTK::Frame {
      }
      default {
      }
    }
    self.setType('GTK::Frame');
  }

  method new {
    my $frame = gtk_frame_new();
    self.bless(:$frame);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method label is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_frame_get_label($!f);
      },
      STORE => sub ($, Str $label is copy) {
        gtk_frame_set_label($!f, $label);
      }
    );
  }

  method label_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_frame_get_label_widget($!f);
      },
      STORE => sub ($, $label_widget is copy) {
        gtk_frame_set_label_widget($!f, $label_widget);
      }
    );
  }

  method shadow_type is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_frame_get_shadow_type($!f);
      },
      STORE => sub ($, $type is copy) {
        gtk_frame_set_shadow_type($!f, $type);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_label_align (Num() $xalign, Num() $yalign) {
    my num32 $x = $xalign;
    my num32 $y = $yalign;

    gtk_frame_get_label_align($!f, $x, $y);
  }

  method get_type {
    gtk_frame_get_type();
  }

  method _set_label_align (Num() $xalign, Num() $yalign) {
    my num32 $x = $xalign;
    my num32 $y = $yalign;

    gtk_frame_set_label_align($!f, $x, $y);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
