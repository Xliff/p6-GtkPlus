use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::LockButton;
use GTK::Raw::Types;

use GTK::Roles::Actionable;

use GTK::Button;

my subset LockButtonAncestry is export
  when GtkLockButton | GtkActionable  | ButtonAncestry;

class GTK::LockButton is GTK::Button {
  also does GTK::Roles::Actionable;
  
  has GtkLockButton $!lb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::LockButton');
    $o;
  }

  submethod BUILD(:$button) {
    my $to-parent;
    given $button {
      when LockButtonAncestry {
        $!lb = do {
          when GtkLockButton {
            $to-parent = nativecast(GtkButton, $_);
            $_;
          }
          when GtkActionable {
            $!action = $_;
            $to-parent = nativecast(GtkButton, $_);
            nativecast(GtkLockButton, $button);
          }
          default {
            $to-parent = $_;
            nativecast(GtkLockButton, $button);
          }
        };
        $!action //= nativecast(GtkActionable, $button);
        self.setButton($to-parent);
      }
      when GTK::Button {
      }
      default {
      }
    }
  }

  multi method new (LockButtonAncestry $button) {
    my $o = self.bless(:$button);
    $o.upref;
    $o;
  }
  multi method new (GPermission() $p) {
    my $button = gtk_lock_button_new($p);
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
  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_lock_button_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
