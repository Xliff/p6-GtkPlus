use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::Offscreen;
use GTK::Raw::Types;

use GDK::Pixbuf;

use GTK::Window;

our subset OffscreenAncestry is export
  where GtkOffscreen | WindowAncestry;

class GTK::Offscreen is GTK::Window {
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
            $to-parent = nativecast(GtkWindow, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkOffscreen, $_);
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
  
  method GTK::Raw::Definitions::GtkOffscreen is also<Offscreen> { $!ow }

  multi method new (OffscreenAncestry $offscreen) {
    self.bless(:$offscreen);
  }
  multi method new {
    my $offscreen = gtk_offscreen_window_new();
    self.bless(:$offscreen);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_pixbuf 
    is also<
      get-pixbuf
      pixbuf
    >
 {
    GDK::Pixbuf.new( gtk_offscreen_window_get_pixbuf($!ow) );
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
