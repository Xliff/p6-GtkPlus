use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::Fixed;
use GTK::Raw::Types;

use GTK::Container;

our subset FixedAncestry is export 
  where GtkFixed | ContainerAncestry;

class GTK::Fixed is GTK::Container {
  has GtkFixed $!f is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$fixed) {
    my $to-parent;
    given $fixed {
      when FixedAncestry {
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
  
  method GTK::Raw::Definitions::GtkFixed is also<Fixed> { $!f }

  multi method new (FixedAncestry $fixed) {
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
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_fixed_get_type, $n, $t );
  }

  multi method move (GtkWidget() $widget, Int() $x, Int() $y) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_fixed_move($!f, $widget, $xx, $yy);
  }

  multi method put (GtkWidget() $widget, Int() $x, Int() $y) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_fixed_put($!f, $widget, $xx, $yy);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method child-set(GtkWidget() $c, *@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'x' | 'y'   { self.child-set-int($c, $p, $v)  }

        default          { take $p; take $v;               }
      }
    }
    nextwith($c, @notfound) if +@notfound;
  }
}
