use v6.c;

use Method::Also;

use GTK::Raw::Offscreen:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GDK::Pixbuf;

use GTK::Window:ver<3.0.1146>;

our subset OffscreenAncestry is export
  where GtkOffscreen | WindowAncestry;

class GTK::Offscreen:ver<3.0.1146> is GTK::Window {
  has GtkOffscreen $!ow is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$offscreen) {
    my $to-parent;
    given $offscreen {
      when OffscreenAncestry {
        $!ow = do {
          when GtkOffscreen  {
            $to-parent = cast(GtkWindow, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkOffscreen, $_);
          }
        }
        self.setWindow($to-parent);
      }
      when GTK::Offscreen {
      }
      default {
      }
    }
  }

  method GTK::Raw::Definitions::GtkOffscreen
    is also<
      Offscreen
      GtkOffscreen
    >
  { $!ow }

  multi method new (OffscreenAncestry $offscreen) {
    $offscreen ?? self.bless(:$offscreen) !! Nil;
  }
  multi method new {
    my $offscreen = gtk_offscreen_window_new();

    $offscreen ?? self.bless(:$offscreen) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_pixbuf (:$raw = False)
    is also<
      get-pixbuf
      pixbuf
    >
  {
    my $p = gtk_offscreen_window_get_pixbuf($!ow);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;
  }

  method get_surface
    is also<
      get-surface
      surface
    >
  {
    gtk_offscreen_window_get_surface($!ow);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_offscreen_window_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
