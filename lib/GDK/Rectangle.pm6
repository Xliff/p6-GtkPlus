use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::Rectangle;

class GDK::Rectangle {
  has GdkRectangle $!r is implementor handles <x y width height>;

  submethod BUILD(:$rectangle) {
    $!r = $rectangle;
  }

  method GDK::Raw::Types::GdkRectangle
    is also<
      rectangle
      GdkRectangle
    >
  { $!r }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method new {
    my $rectangle = GdkRectangle.new;
    self.bless(:$rectangle);
  }
  multi method new (GdkRectangle $rectangle) {
    self.bless(:$rectangle);
  }

  method equal (GdkRectangle() $rect2) {
    gdk_rectangle_equal($!r, $rect2);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_rectangle_get_type, $n, $t );
  }

  method intersect (GdkRectangle() $src2, GdkRectangle() $dest) {
    gdk_rectangle_intersect($!r, $src2, $dest);
  }

  method union (GdkRectangle() $src2, GdkRectangle() $dest) {
    gdk_rectangle_union($!r, $src2, $dest);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑
}


sub infix:<∩> (GdkRectangle() $a, GdkRectangle() $b) is export {
  my $d = GdkRectangle.new;
  gdk_rectangle_intersect($a, $b, $d);
  GDK::Rectangle.new($d);
}

sub infix:<∪> (GdkRectangle() $a, GdkRectangle() $b) is export {
  my $d = GdkRectangle.new;
  gdk_rectangle_union($a, $b, $d);
  GDK::Rectangle.new($d);
}
