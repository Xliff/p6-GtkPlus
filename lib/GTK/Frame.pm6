use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Frame;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::Frame is GTK::Bin {
  has GtkFrame $!f;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Frame');
    $o;
  }

  submethod BUILD(:$frame) {
    my $to-parent;
    given $frame {
      when GtkFrame | GtkWidget {
        $!f = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkFrame, $_);
          }
          when GtkFrame {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
        };
        self.setBin($to-parent);
      }
      when GTK::Frame {
      }
      default {
      }
    }
  }

  multi method new (GtkWidget $frame) {
    self.bless(:$frame);
  }
  multi method new(Str() $label) {
    my $frame = gtk_frame_new($label);
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
      STORE => sub ($, Str() $label is copy) {
        gtk_frame_set_label($!f, $label);
      }
    );
  }

  method label_widget is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_frame_get_label_widget($!f);
      },
      STORE => sub ($, GtkWidget() $label_widget is copy) {
        gtk_frame_set_label_widget($!f, $label_widget);
      }
    );
  }

  method shadow_type is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkShadowType( gtk_frame_get_shadow_type($!f) );
      },
      STORE => sub ($, Int() $type is copy) {
        my uint32 $t = self.RESOLVE-UINT($type);
        gtk_frame_set_shadow_type($!f, $t);
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

  method set_label_align (Num() $xalign, Num() $yalign) {
    my num32 $x = $xalign;
    my num32 $y = $yalign;

    gtk_frame_set_label_align($!f, $x, $y);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
