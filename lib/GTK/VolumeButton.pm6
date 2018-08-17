use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::ScaleButton;

use GTK::ScaleButton;

class GTK::VolumeButton is GTK::ScaleButton {
  has GtkVolumeButton $!vb;

  submethod BUILD(:$button) {
    given $button {
      when GtkVolume | GtkWidget {
        $!vb = nativecast(GtkVolumeButton, $button);
        self.setScaleButton($button);
      }
      when GTK::VolumeButton {
      }
      default {
      }
    }
  }

  method new {
    $button = gtk_volume_button_new();
    self.bless(:$button);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type () {
    gtk_volume_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
