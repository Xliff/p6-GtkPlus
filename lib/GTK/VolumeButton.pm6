use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::VolumeButton;

use GTK::ScaleButton;

use GTK::Roles::Orientable;

my subset Ancestry
  where GtkVolumeButton | GtkScaleButton | GtkOrientable | GtkButton |
        GtkBin          | GtkContainer   | GtkBuilder    | GtkWidget;

class GTK::VolumeButton is GTK::ScaleButton {
  also does GTK::Roles::Orientable;

  has GtkVolumeButton $!vb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::VolumeButton');
    $o;
  }

  submethod BUILD(:$button) {
    given $button {
      my $to-parent;
      when Ancestry {
        $!vb = do {
          when GtkVolumeButton {
            $to-parent = nativecast(GtkScaleButton, $_);
            $_;
          }
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkVolumeButton, $_);
          }
        }
        self.setScaleButton($to-parent);
      }
      when GTK::VolumeButton {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $button) {
    my $o = self.bless(:$button);
    $o.upref;
    $o;
  }
  multi method new {
    my $button = gtk_volume_button_new();
    self.bless(:$button);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_volume_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
