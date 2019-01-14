use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Fixed;
use GTK::Raw::Types;

use GTK::Container;

my subset Ancestry where GtkFixed | GtkContainer | GtkBuildable | GtkWidget;

class GTK::Fixed is GTK::Container {
  has GtkFixed $!f;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Fixed');
    $o;
  }

  submethod BUILD(:$fixed) {
    my $to-parent;
    given $fixed {
      when Ancestry {
        $!f = do {
          when GtkFixed {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkFixed, $_);
          }
        };
        self.setContainer($to-parent);
      }
      when GTK::Fixed {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $fixed) {
    my $o = self.bless(:$fixed);
    $o.upref;
    $o;
  }
  multi method new {
    my $fixed = gtk_fixed_new();
    self.bless(:$fixed);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_fixed_get_type();
  }

  multi method move (GtkWidget() $widget, Int() $x, Int() $y) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_fixed_move($!f, $widget, $xx, $yy);
  }

  multi method put (GtkWidget $widget, Int() $x, Int() $y) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_fixed_put($!f, $widget, $xx, $yy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method child-set(*@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'x' | 'y'   { self.child-set-int($p, $v)  }

        default          { take $p; take $v;           }
      }
    }
    nextwith(@notfound) if +@notfound;
  }
}
