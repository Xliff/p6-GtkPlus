use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Offscreen;
use GTK::Raw::Types;

use GTK::Window;

class GTK::Offscreen is GTK::Window {
  has Gtk $!ow;

  submethod BUILD(:$offscreen) {
    my $to-parent;
    given $ {
      when GtkOffscreen | GtkWidget {
        $!ow = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkOffscreen, $_);
          }
          when GtkOffscreen  {
            $to-parent = nativecast(GtkWindow, $_);
            $_;
          }
        }
        self.setParent($to-parent);
      }
      when GTK::Offscreen {
      }
      default {
      }
    }
    self.setType('GTK::Offscreen');
  }

  method new {
    my $offscreen = gtk_offscreen_window_new();
    self.bless(:$offscreen);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_pixbuf {
    gtk_offscreen_window_get_pixbuf($!ow);
  }

  method get_surface {
    gtk_offscreen_window_get_surface($!ow);
  }

  method get_type {
    gtk_offscreen_window_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
