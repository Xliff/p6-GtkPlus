use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::VolumeButton;

use GTK::ScaleButton;

class GTK::VolumeButton is GTK::ScaleButton {
  has GtkVolumeButton $!vb;

  submethod BUILD(:$button) {
    given $button {
      when GtkVolumeButton | GtkWidget {
        $!vb = do {
          when GtkWidget       { nativecast(GtkVolumeButton, $button); }
          when GtkVolumeButton { $button; }
        }
        self.setScaleButton($button);
      }
      when GTK::VolumeButton {
      }
      default {
      }
    }
    self.setType('GTK::VolumeButton');
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
