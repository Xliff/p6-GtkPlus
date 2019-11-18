use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::VolumeButton;

use GTK::ScaleButton;

use GTK::Roles::Orientable;

our subset VolumeButtonAncestry is export
  where GtkVolumeButton | ScaleButtonAncestry;

class GTK::VolumeButton is GTK::ScaleButton {
  also does GTK::Roles::Orientable;

  has GtkVolumeButton $!vb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$button) {
    given $button {
      my $to-parent;
      when VolumeButtonAncestry {
        $!vb = do {
          when GtkVolumeButton {
            $to-parent = nativecast(GtkScaleButton, $_);
            $_;
          }
          default {
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

  multi method new (VolumeButtonAncestry $button) {
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
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_volume_button_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
