use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;

use GIO::Permission;

our subset SimplePermissionAncestry is export of Mu
  where GSimplePermission | GPermission;

class GIO::SimplePermission is GIO::Permission {
  has GSimplePermission $!sp is implementor;

  submethod BUILD (:$simple-permission) {
    given $simple-permission {
      when SimplePermissionAncestry {
        my $to-parent;
        $!sp = do {
          when GSimplePermission {
            $to-parent = cast(GPermission, $_);
            $_;
          }

          when GPermission {
            $to-parent = $_;
            cast(GSimplePermission, $_);
          }
        };
        self.setPermission($to-parent);
      }

      when GIO::SimplePermission {
      }

      default {
      }
    }
  }

  method GLib::Raw::Types::GSimplePermission
    is also<GSimplePermission>
  { $!sp }

  method new (Int() $allowed) {
    my gboolean $a = so $allowed;
    my $sp = g_simple_permission_new($a);

    $sp ?? self.bless( simple-permission => $sp ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_simple_permission_get_type, $n, $t );
  }

}


sub g_simple_permission_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_simple_permission_new (gboolean $allowed)
  returns GSimplePermission
  is native(gio)
  is export
{ * }
