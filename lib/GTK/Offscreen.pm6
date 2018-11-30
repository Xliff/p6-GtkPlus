use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Offscreen;
use GTK::Raw::Types;

use GTK::Window;

my subset Ancestry
  where GtkOffscreen | GtkWindow | GtkBin | GtkContainer | GtkBuildable |
        GtkWidget;

class GTK::Offscreen is GTK::Window {
  has GtkOffscreen $!ow;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Offscreen');
    $o;
  }

  submethod BUILD(:$offscreen) {
    my $to-parent;
    given $offscreen {
      when Ancestry {
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
        self.setParent($to-parent);
      }
      when GTK::Offscreen {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $offscreen) {
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
  method get_pixbuf is also<get-pixbuf> {
    gtk_offscreen_window_get_pixbuf($!ow);
  }

  method get_surface is also<get-surface> {
    gtk_offscreen_window_get_surface($!ow);
  }

  method get_type is also<get-type> {
    gtk_offscreen_window_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
