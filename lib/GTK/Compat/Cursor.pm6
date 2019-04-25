use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Display;
use GTK::Compat::Pixbuf;
use GTK::Compat::Types;
use GTK::Compat::Raw::Cursor;

use GTK::Raw::Utils;

class GTK::Compat::Cursor {
  has GdkCursor $!c;

  submethod BUILD(:$cursor) {
    $!c = $cursor
  }

  multi method new (GdkCursor $cursor) {
    self.bless(:$cursor);
  }
  multi method new (Int() $cursor_type) {
    my uint32 $ct = resolve-uint($cursor_type);
    my $cursor = gdk_cursor_new($ct);
    self.bless(:$cursor);
  }

  method GTK::Compat::Types::GdkCursor is also<gdkcursor> {
    $!c;
  }

  method new_for_display (
    GdkDisplay() $display,
    Int() $cursor_type          # GdkCursorType $cursor_type
  )
    is also<new-for-display>
  {
    my uint32 $ct = resolve-uint($cursor_type);
    my $cursor = gdk_cursor_new_for_display($display, $ct);
    self.bless(:$cursor);
  }

  method new_from_name (GdkDisplay() $display, Str() $name)
    is also<new-from-name>
  {
    my $cursor = gdk_cursor_new_from_name($display, $name);
    self.bless(:$cursor);
  }

  method new_from_pixbuf (
    GdkDisplay() $display,
    GdkPixbuf() $pixbuf,
    Int() $x,
    Int() $y
  )
    is also<new-from-pixbuf>
  {
    my @i = ($x, $y);
    my gint ($xx, $yy) = resolve-int(@i);
    my $cursor = gdk_cursor_new_from_pixbuf($display, $pixbuf, $xx, $yy);
    self.bless(:$cursor);
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
    gdk_cursor_new_from_surface($display, $surface, $xx, $yy);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method cursor_type is also<cursor-type> {
    GdkCursorType( gdk_cursor_get_cursor_type($!c) );
  }

  method display
    is also<get-display>
    is also<get_display>
  {
    GTK::Compat::Display.new( gdk_cursor_get_display($!c) );
  }

  method get_image is also<get-image> {
    GDK::Compat::Pixbuf( gdk_cursor_get_image($!c) );
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
