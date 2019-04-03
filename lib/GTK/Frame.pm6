use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Value;
use GTK::Raw::Frame;
use GTK::Raw::Types;

use GTK::Bin;

our subset FrameAncestry is export where GtkFrame | BinAncestry;

class GTK::Frame is GTK::Bin {
  has GtkFrame $!f;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD(:$frame) {
    my $to-parent;
    given $frame {
      when FrameAncestry {
        $!f = do {
          when GtkFrame {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
          when BinAncestry {
            $to-parent = $_;
            nativecast(GtkFrame, $_);
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

  multi method new (FrameAncestry $frame) {
    my $o = self.bless(:$frame);
    $o.upref;
    $o;
  }
  multi method new(Str() $label) {
    my $frame = gtk_frame_new($label);
    self.bless(:$frame);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # Type: gfloat
  method label-xalign is rw is also<label_xalign> {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('label-xalign', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('label-xalign', $gv);
      }
    );
  }

  # Type: gfloat
  method label-yalign is rw is also<label_yalign> {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('label-yalign', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('label-yalign', $gv);
      }
    );
  }

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

  method label_widget is rw is also<label-widget> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_frame_get_label_widget($!f);
      },
      STORE => sub ($, GtkWidget() $label_widget is copy) {
        gtk_frame_set_label_widget($!f, $label_widget);
      }
    );
  }

  method shadow_type is rw is also<shadow-type> {
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
  method get_label_align (Num() $xalign, Num() $yalign)
    is also<get-label-align>
  {
    my num32 $x = $xalign;
    my num32 $y = $yalign;

    gtk_frame_get_label_align($!f, $x, $y);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_frame_get_type, $n, $t );
  }

  method set_label_align (Num() $xalign, Num() $yalign)
    is also<set-label-align>
  {
    my num32 $x = $xalign;
    my num32 $y = $yalign;

    gtk_frame_set_label_align($!f, $x, $y);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
