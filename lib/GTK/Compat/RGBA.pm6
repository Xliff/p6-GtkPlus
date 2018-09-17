use v6.c;

use NativeCall;

use GTK::Compat::Types;

class GdkRGBA is repr('CStruct') is export {
  has gdouble $.red;
  has gdouble $.green;
  has gdouble $.blue;
  has gdouble $.alpha;

  method copy {
    gdk_rgba_copy($!c);
  }

  method equal (GdkRGBA $p2) {
    Bool( gdk_rgba_equal($!c, $p2) );
  }

  method free {
    gdk_rgba_free($!c);
  }

  method get_type {
    gdk_rgba_get_type();
  }

  method hash {
    gdk_rgba_hash($!c);
  }

  method parse (gchar $spec) {
    Bool( gdk_rgba_parse($!c, $spec) );
  }

  method to_string {
    gdk_rgba_to_string($!c);
  }

}

sub infix:<eqv> (GdkRGBA $a, GdkRGBA $b) {
  $a.equal($b);
}

sub gdk_rgba_copy (GdkRGBA $rgba)
  returns GdkRGBA
  is native('gtk-3')
  is export
  { * }

sub gdk_rgba_equal (gconstpointer $p1, gconstpointer $p2)
  returns uint32
  is native('gdk-3')
  is export
  { * }

sub gdk_rgba_free (GdkRGBA $rgba)
  is native('gdk-3')
  is export
  { * }

sub gdk_rgba_get_type ()
  returns GType
  is native('gdk-3')
  is export
  { * }

sub gdk_rgba_hash (gconstpointer $p)
  returns guint
  is native('gdk-3')
  is export
  { * }

sub gdk_rgba_parse (GdkRGBA $rgba, gchar $spec)
  returns uint32
  is native('gdk-3')
  is export
  { * }

sub gdk_rgba_to_string (GdkRGBA $rgba)
  returns Str
  is native('gdk-3')
  is export
  { * }
