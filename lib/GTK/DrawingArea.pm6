use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Widget;

our subset DrawingAreaAncestry is export of Mu
  where GtkDrawingArea | WidgetAncestry;

sub gtk_drawing_area_get_type ()
  returns GType
  is native(gtk)
  { * }

sub gtk_drawing_area_new ()
  returns GtkDrawingArea
  is native(gtk)
  { * }

class GTK::DrawingArea is GTK::Widget {
  has GtkDrawingArea $!da is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$draw) {
    given $draw {
      when DrawingAreaAncestry {
        self.setDrawingArea($draw);
      }
      when GTK::DrawingArea {
      }
      default {
      }
    }
  }

  method setDrawingArea (DrawingAreaAncestry $draw) {
    self.IS-PROTECTED;
    
    my $to-parent;
    $!da = do given $draw {
      when GtkDrawingArea {
        $to-parent = nativecast(GtkWidget, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkDrawingArea, $_);
      }
    }
    self.setWidget($to-parent);
  }

  multi method new (DrawingAreaAncestry $draw) {
    my $o = self.bless(:$draw);
    $o.upref;
    $o;
  }
  multi method new {
    my $draw = gtk_drawing_area_new();
    self.bless(:$draw);
  }

  method GTK::Raw::Types::GtkDrawingArea is also<DrawingArea> { $!da }

  # cw: Is this true?!?
  method GTK::Compat::Types::cairo_t is also<cairo_t> {
    nativecast(cairo_t, $!da);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_drawing_area_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
