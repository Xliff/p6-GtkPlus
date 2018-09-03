use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::LockButton;
use GTK::Raw::Types;

use GTK::Button;

class GTK::LockButton is GTK::Button {
  has GtkLockButton $!lb;

  submethod BUILD(:$button) {
    given $button {
      when GtkLockButton | GtkWidget {
        $!lb = do {
          when GtkWidget     { nativecast(GtkLockButton, $button); }
          when GtkLockButton { $button; }
        };
        self.setButton($button);
      }
      when GTK::Button {
      }
      default {
      }
    }
    self.setType('GTK::LockButton');
  }

  method new {
    my $button = gtk_lock_button_new();
    self.bless(:$button);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method permission is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_lock_button_get_permission($!lb);
      },
      STORE => sub ($, $permission is copy) {
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
