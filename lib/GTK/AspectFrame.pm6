use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::AspectFrame:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;
use GTK::Frame:ver<3.0.1146>;

our subset AspectFrameAncestry is export
  where GtkAspectFrame | FrameAncestry;

class GTK::AspectFrame:ver<3.0.1146> is GTK::Frame {
  has GtkAspectFrame $!af is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$frame) {
    my $to-parent;
    given $frame {
      when AspectFrameAncestry {
        $!af = do {
          when GtkAspectFrame {
            $to-parent = nativecast(GtkFrame, $_);
            $_;
          }
          when FrameAncestry {
            $to-parent = $_;
            nativecast(GtkAspectFrame, $_);
          }
        }
        self.setFrame($to-parent);
      }
      when GTK::AspectFrame {
      }
      default {
      }
    }
  }

  method GTK::Raw::Definitions::GtkAspectFrame
    is also<GtkAspectFrame>
  { $!af }

  multi method new (AspectFrameAncestry $frame, :$ref = True) {
    return Nil unless $frame;

    my $o = self.bless(:$frame);
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() $label,
    Num() $xalign,
    Num() $yalign,
    Num() $ratio,
    Int() $obey_child
  ) {
    my gdouble ($xa, $ya, $r) = ($xalign, $yalign, $ratio);
    my $o = $obey_child.so.Int;
    my $frame = gtk_aspect_frame_new($label, $xa, $ya, $r, $o);

    $frame ?? self.bless(:$frame) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method obey-child is rw is also<obey_child> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('obey-child', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set('obey-child', $gv)
      }
    );
  }

  # Type: gfloat
  method ratio is rw {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('ratio', $gv);
        $gv.float
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('ratio', $gv)
      }
    );
  }

  # Type: gfloat
  method xalign is rw {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('xalign', $gv);
        $gv.float;
      },
       STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('xalign', $gv)
      }
    );
  }

  # Type: gfloat
  method yalign is rw {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('yalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('yalign', $gv)
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_aspect_frame_get_type, $n, $t );
  }

  method set (
    Num() $xalign,
    Num() $yalign,
    Num() $ratio,
    Int() $obey_child
  ) {
    my gdouble ($xa, $ya, $r) = ($xalign, $yalign, $ratio);
    my $o = $obey_child.so.Int;

    gtk_aspect_frame_set($!af, $xa, $ya, $r, $o);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
