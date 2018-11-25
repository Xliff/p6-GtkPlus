use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Rectangle;

class GTK::Compat::Rectangle {
  has GdkRectangle $!r handles <x y width height>;

  submethod BUILD(:$rectangle) {
    $!r = $rectangle;
  }

  method GTK::Compat::Types::GdkRectangle is also<rectangle> {
    $!r;
  }

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
    gdk_rectangle_get_type();
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
  GTK::Compat::Rectangle.new($d);
}

sub infix:<∪> (GdkRectangle() $a, GdkRectangle() $b) is export {
  my $d = GdkRectangle.new;
  gdk_rectangle_union($a, $b, $d);
  GTK::Compat::Rectangle.new($d);
}
