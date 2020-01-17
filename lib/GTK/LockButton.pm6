use v6.c;

use Method::Also;

use GTK::Raw::LockButton;
use GTK::Raw::Types;

use GTK::Roles::Actionable;

use GTK::Button;

my subset LockButtonAncestry is export
  when GtkLockButton | GtkActionable  | ButtonAncestry;

class GTK::LockButton is GTK::Button {
  also does GTK::Roles::Actionable;

  has GtkLockButton $!lb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$lock-button) {
    my $to-parent;
    given $lock-button {
      when LockButtonAncestry {
        $!lb = do {
          when GtkLockButton {
            $to-parent = cast(GtkButton, $_);
            $_;
          }
          when GtkActionable {
            $!action = $_;
            $to-parent = cast(GtkButton, $_);
            cast(GtkLockButton, $_);
          }
          default {
            $to-parent = $_;
            cast(GtkLockButton, $_);
          }
        };
        $!action //= cast(GtkActionable, $_);
        self.setButton($to-parent);
      }
      when GTK::Button {
      }
      default {
      }
    }
  }

  multi method new (LockButtonAncestry $lock-button, :$ref = True) {
    return Nil unless $lock-button;

    my $o = self.bless(:$lock-button);
    $o.ref if $ref;
    $o;
  }
  multi method new (GPermission() $p) {
    my $lock-button = gtk_lock_button_new($p);

    $lock-button ?? self.bless(:$lock-button) !! Nil;
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method permission (:$raw = False) is rw {
    # GPermission
    Proxy.new(
      FETCH => sub ($) {
        my $p = gtk_lock_button_get_permission($!lb);

        $p ??
          ( $raw ?? $p !! GDK::Permission.new($p) )
          !!
          Nil;
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
