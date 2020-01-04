use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;

class GDK::RGBA is repr<CStruct> is export { ... }

our constant GdkRGBA is export := GDK::RGBA;

# STRUCT. No Object representation

class GDK::RGBA {
  has gdouble $.red   is rw;
  has gdouble $.green is rw;
  has gdouble $.blue  is rw;
  has gdouble $.alpha is rw;

  submethod BUILD (:$!red, :$!green, :$!blue, :$!alpha) { }

  method GDK::Raw::Types::GdkRGBA
  { self }

  multi method new (
    Num() $red   = 0,
    Num() $green = 0,
    Num() $blue  = 0,
    Num() $alpha = 1
  ) {
    self.bless(:$red, :$green, :$blue, :$alpha);
  }

  method new-rgba (
    Int() $red  ,
    Int() $green,
    Int() $blue ,
    Num() $alpha = 1e0
  )
    is also<new_rgba>
  {
    die '$alpha must be between 0 and 1'  unless $alpha ~~ 0..1;
    GDK::RGBA.new(
      $red   / 255,
      $green / 255,
      $blue  / 255,
      :$alpha
    )
  }

  method new-rgb (
    Int() $red  ,
    Int() $green,
    Int() $blue
  )
    is also<new_rgb>
  {
    GDK::RGBA.new(
      $red   / 255,
      $green / 255,
      $blue  / 255
    );
  }

  method copy (:$raw = False) {
    gdk_rgba_copy(self);
  }

  method equal (GDK::RGBA $p2) {
    Bool( gdk_rgba_equal(self, $p2) );
  }

  method free {
    gdk_rgba_free(self);
  }

  method get_type is also<get-type> {
    my ($n, $t);

    unstable_get_type( self.^name, &gdk_rgba_get_type, $n, $t )
  }

  method hash {
    gdk_rgba_hash(self);
  }

  method parse (Str() $spec) {
    so gdk_rgba_parse(self, $spec);
  }

  method rgb {
    (self.red, self.green, self.blue);
  }

  method rgba is also<Array> {
    (self.red, self.green, self.blue, self.alpha);
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    gdk_rgba_to_string(self);
  }

}

sub infix:<eqv> (GDK::RGBA $a, GTK::Compat::RGBA $b) {
  $a.equal($b);
}

sub gdk_rgba_copy (GDK::RGBA $rgba)
  returns GDK::RGBA
  is native(gtk)
  is export
  { * }

sub gdk_rgba_equal (GDK::RGBA $p1, GTK::Compat::RGBA $p2)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_rgba_free (GDK::RGBA $rgba)
  is native(gdk)
  is export
  { * }

sub gdk_rgba_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_rgba_hash (GDK::RGBA $p)
  returns guint
  is native(gdk)
  is export
  { * }

sub gdk_rgba_parse (GDK::RGBA $rgba, gchar $spec)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_rgba_to_string (GDK::RGBA $rgba)
  returns Str
  is native(gdk)
  is export
  { * }
