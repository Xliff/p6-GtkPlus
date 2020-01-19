use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Frame;
use GTK::Raw::Types;

use GLib::Value;
use GTK::Bin;

our subset FrameAncestry is export where GtkFrame | BinAncestry;

class GTK::Frame is GTK::Bin {
  has GtkFrame $!f is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
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

  multi method new (FrameAncestry $frame, :$ref = True) {
    return Nil unless $frame;

    my $o = self.bless(:$frame);
    $o.ref if $ref;
    $o;
  }
  multi method new(Str() $label = '') {
    my $frame = gtk_frame_new($label);

    $frame ?? self.bless(:$frame) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # Type: gfloat
  method label-xalign is rw is also<label_xalign> {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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

  method label_widget (:$raw = False, :$widget = False)
    is rw
    is also<label-widget>
  {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_frame_get_label_widget($!f);

        self.ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, GtkWidget() $label_widget is copy) {
        gtk_frame_set_label_widget($!f, $label_widget);
      }
    );
  }

  method shadow_type is rw is also<shadow-type> {
    Proxy.new(
      FETCH => sub ($) {
        GtkShadowTypeEnum( gtk_frame_get_shadow_type($!f) );
      },
      STORE => sub ($, Int() $type is copy) {
        my uint32 $t = $type;

        gtk_frame_set_shadow_type($!f, $t);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  proto method get_label_align (|)
    is also<get-label-align>
  { * }

  multi method get_label_align {
    samewith($, $);
  }
  multi method get_label_align ($xalign is rw, $yalign is rw) {
    my num32 ($x, $y) = 0e0 xx 2;

    gtk_frame_get_label_align($!f, $x, $y);
    ($xalign, $yalign) = ($x, $y);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_frame_get_type, $n, $t );
  }

  method set_label_align (Num() $xalign, Num() $yalign)
    is also<set-label-align>
  {
    my num32 ($x, $y) = ($xalign, $yalign);

    gtk_frame_set_label_align($!f, $x, $y);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
