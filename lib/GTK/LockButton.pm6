use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::LockButton;
use GTK::Raw::Types;

use GTK::Button;

class GTK::LockButton is GTK::Button {
  has GtkLockButton $!lb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::LockButton');
    $o;
  }

  submethod BUILD(:$button) {
    my $to-parent;
    given $button {
      when GtkLockButton | GtkWidget {
        $!lb = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkLockButton, $button);
          }
          when GtkLockButton {
            $to-parent = nativecast(GtkButton, $_);
            $_;
          }
        };
        self.setButton($to-parent);
      }
      when GTK::Button {
      }
      default {
      }
    }
  }

  multi method new (GPermission $p) {
    my $button = gtk_lock_button_new($p);
    self.bless(:$button);
  }
  multi method new (GtkWidget $button) {
    self.bless(:$button);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method permission is rw {
    # GPermission
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::Permission.new(
          gtk_lock_button_get_permission($!lb)
        )
      },
      STORE => sub ($, GPermission() $permission is copy) {
        gtk_lock_button_set_permission($!lb, $permission);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_lock_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
