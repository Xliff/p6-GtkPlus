use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Widget;

my subset Ancestry where GtkDrawingArea | GtkBuildable | GtkWidget;

sub gtk_drawing_area_get_type ()
  returns GType
  is native(gtk)
  { * }

sub gtk_drawing_area_new ()
  returns GtkDrawingArea
  is native(gtk)
  { * }

class GTK::DrawingArea is GTK::Widget {
  has GtkDrawingArea $!da;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::DrawingArea');
    $o;
  }

  submethod BUILD(:$draw) {
    my $to-parent;
    given $draw {
      when Ancestry {
        $!da = do {
          when GtkDrawingArea {
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkDrawingArea, $_);
          }
        }
        self.setWidget($to-parent);
      }
      when GTK::DrawingArea {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $draw) {
    my $o = self.bless(:$draw);
    $o.upref;
    $o;
  }
  multi method new {
    my $draw = gtk_drawing_area_new();
    self.bless(:$draw);
  }

  method GTK::Raw::Types::GtkDrawingArea is also<area> {
    $!da;
  }
  method GTK::Compat::Types::cairo_t is also<cairo_t> {
    nativecast(cairo_t, $!da);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_drawing_area_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
