use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Widget:ver<3.0.1146>;

our subset GtkDrawingAreaAncestry is export of Mu
  where GtkDrawingArea | GtkWidgetAncestry;

constant DrawingAreaAncestry is export := GtkDrawingAreaAncestry;

sub gtk_drawing_area_get_type ()
  returns GType
  is native(gtk)
{ * }

sub gtk_drawing_area_new ()
  returns GtkDrawingArea
  is native(gtk)
{ * }

class GTK::DrawingArea:ver<3.0.1146> is GTK::Widget {
  has GtkDrawingArea $!da is implementor;

  submethod BUILD( :$draw ) {
    self.setGtkDrawingArea($draw) if $draw;
  }

  method setGtkDrawingArea (GtkDrawingAreaAncestry $_)
    is also<setDrawingArea>
  {
    my $to-parent;
    $!da = do {
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

  multi method new (GtkDrawingAreaAncestry $draw, :$ref = True) {
    return Nil unless $draw;

    my $o = self.bless(:$draw);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $draw = gtk_drawing_area_new();

    $draw ?? self.bless( :$draw ) !! Nil;
  }

  method GTK::Raw::Definitions::GtkDrawingArea
    is also<
      GtkDrawingArea
      DrawingArea
    >
  { $!da }

  method Cairo::cairo_t is also<cairo_t> {
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
