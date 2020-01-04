use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::Cursor;

use GDK::Display;
use GDK::Pixbuf;

use GTK::Raw::Utils;

class GDK::Cursor {
  has GdkCursor $!c is implementor;

  submethod BUILD(:$cursor) {
    $!c = $cursor
  }

  method GDK::Raw::Types::GdkCursor
    is also<
      gdkcursor
      GdkCursor
    >
  { $!c }

  multi method new (GdkCursor $cursor) {
    $cursor ?? self.bless(:$cursor) !! Nil;
  }
  multi method new (Int() $cursor_type) {
    my uint32 $ct = $cursor_type;
    my $cursor = gdk_cursor_new($ct);

    $cursor ?? self.bless(:$cursor) !! Nil;
  }

  method new_for_display (
    GdkDisplay() $display,
    Int() $cursor_type          # GdkCursorType $cursor_type
  )
    is also<new-for-display>
  {
    my uint32 $ct = $cursor_type;
    my $cursor = gdk_cursor_new_for_display($display, $ct);

    $cursor ?? self.bless(:$cursor) !! Nil;
  }

  method new_from_name (GdkDisplay() $display, Str() $name)
    is also<new-from-name>
  {
    my $cursor = gdk_cursor_new_from_name($display, $name);

    $cursor ?? self.bless(:$cursor) !! Nil;
  }

  method new_from_pixbuf (
    GdkDisplay() $display,
    GdkPixbuf() $pixbuf,
    Int() $x,
    Int() $y
  )
    is also<new-from-pixbuf>
  {
    my gint ($xx, $yy) = ($x, $y);
    my $cursor = gdk_cursor_new_from_pixbuf($display, $pixbuf, $xx, $yy);

    $cursor ?? self.bless(:$cursor) !! Nil;
  }

  method new_from_surface (
    GdkDisplay() $display,
    cairo_surface_t $surface,
    Num() $x,
    Num() $y
  )
    is also<new-from-surface>
  {
    my gdouble ($xx, $yy) = ($x, $y);
    my $cursor = gdk_cursor_new_from_surface($display, $surface, $xx, $yy);

    $cursor ?? self.bless(:$cursor) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method cursor_type is also<cursor-type> {
    GdkCursorTypeEnum( gdk_cursor_get_cursor_type($!c) );
  }

  method display (:$raw = False);
    is also<
      get-display
      get_display
    >
  {
    my $display = gdk_cursor_get_display($!c);

    $display ??
      ( $raw ?? $display !! GDK::Display.new($display) )
      !!
      Nil;
  }

  method get_image (:$raw = False) is also<get-image> {
    my $image = gdk_cursor_get_image($!c)

    $image ??
      ( $raw ?? $image !! GDK::Pixbuf($image) )
      !!
      Nil;
  }

  method get_surface (Num() $x_hot, Num() $y_hot) is also<get-surface> {
    my gdouble ($xh, $yh) = ($x_hot, $y_hot);

    gdk_cursor_get_surface($!c, $xh, $yh);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_cursor_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
