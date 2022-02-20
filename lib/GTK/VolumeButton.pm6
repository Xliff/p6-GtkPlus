use v6.c;

use Method::Also;

use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::VolumeButton:ver<3.0.1146>;

use GTK::ScaleButton:ver<3.0.1146>;

use GTK::Roles::Orientable:ver<3.0.1146>;

our subset VolumeButtonAncestry is export
  where GtkVolumeButton | ScaleButtonAncestry;

class GTK::VolumeButton:ver<3.0.1146> is GTK::ScaleButton {
  also does GTK::Roles::Orientable;

  has GtkVolumeButton $!vb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$volume-button) {
    given $volume-button {
      my $to-parent;
      when VolumeButtonAncestry {
        $!vb = do {
          when GtkVolumeButton {
            $to-parent = cast(GtkScaleButton, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkVolumeButton, $_);
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

  multi method new (VolumeButtonAncestry $volume-button, $ref = True) {
    return Nil unless $volume-button;

    my $o = self.bless(:$volume-button);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $volume-button = gtk_volume_button_new();

    $volume-button ?? self.bless(:$volume-button) !! Nil;
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
