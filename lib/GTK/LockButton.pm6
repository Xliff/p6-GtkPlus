use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::LockButton;
use GTK::Raw::Types;

use GTK::Button;

my subset Ancestry
  when GtkLockButton | GtkActionable  | GtkButton | GtkBin | GtkContainer |
       GtkBuildable  | GtkWidget;

class GTK::LockButton is GTK::Button {
  has GtkLockButton $!lb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::LockButton');
    $o;
  }

  submethod BUILD(:$button) {
    my $to-parent;
    given $button {
      when Ancestry {
        $!lb = do {
          when GtkLockButton {
            $to-parent = nativecast(GtkButton, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkLockButton, $button);
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

  multi method new (Ancestry $button) {
    my $o = self.bless(:$button);
    $o.upref;
    $o;
  }
  multi method new (GPermission $p) {
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
    gtk_lock_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
